# springboot集成rabbitmq #
## RabbitMQ简介 ##

	RabbitMQ使用Erlang语言开发的开源消息队列系统，基于AMQP协议来实现（AMQP的主要特征是面向消息、队列、路由、可靠性、安全）。支持多种客户端，如：Python、Ruby、.NET、Java、JMS、C、PHP、ActionScript、XMPP、STOMP等，支持AJAX。用于在分布式系统中存储转发消息，在易用性、扩展性、高可用性等方面表现很出色。

	消息队列通常有三个概念：发送消息（生产者）、队列、接收消息（消费者）。RabbitMQ在这个基本概念之上，多做了一层抽象，在发送消息和队列之间，加入了交换机。这样发送消息和队列就没有直接关系，而是通过交换机来做转发，交换机会根据分发策略把消息转给队列。

> 图一（MQ基本模型）：

	P为发送消息（生产者）、Q为消息队列、C为接收消息（消费者）

> 图二（RabbitMQ模型）：

	P为发送消息（生产者）、X为交换机、Q为消息队列、C为接收消息（消费者）

![](https://images2018.cnblogs.com/blog/1308658/201805/1308658-20180521182608882-979039140.png)

图一

![](https://images2018.cnblogs.com/blog/1308658/201805/1308658-20180521182545059-1155725091.png)

图二

## RabbitMQ比较重要的几个概念： ##

	虚拟主机：RabbitMQ支持权限控制，但是最小控制粒度为虚拟主机。一个虚拟主机可以包含多个交换机、队列、绑定。
	
	交换机：RabbitMQ分发器，根据不同的策略将消息分发到相关的队列。
	
	队列：缓存消息的容器。
	
	绑定：设置交换机与队列的关系。

是时候表演真正的技术了

为了方便演示，我们分别创建两个springboot项目：

spring-boot-rabbitmq-producer（生产者）

spring-boot-rabbitmq-consumer（消费者）

注意：实际项目中，一个系统可能即为生产者、又为消费者。

## 1.添加基础配置 ##

生产者、消费者基础配置相同。

1.1）集成rabbitmq，添加maven依赖

	<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>
    
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-amqp</artifactId>
    </dependency>

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
	</dependencies>	

1.2）添加rabbitmq服务配置（application.properties）

	#rabbitmq相关配置
	spring.rabbitmq.host=192.168.15.131
	spring.rabbitmq.port=5672
	spring.rabbitmq.username=admin
	spring.rabbitmq.password=123456

## 2.交换机——DirectExchange ##

DirectExchange是RabbitMQ的默认交换机，直接使用routingKey匹配队列。

![](https://images2018.cnblogs.com/blog/1308658/201805/1308658-20180515095018484-830578829.png)

2.1）添加一个配置类（消费者）

配置一个routingKey为notify.payment的消息队列

	@Configuration
	public class DirectConfig {
    	@Bean
    	public Queue paymentNotifyQueue() {
        return new Queue("notify.payment");
    	}
	}

2.2）添加一个消息监听类（消费者）

监听routingKey为notify.payment的队列消息

	@Component
	@RabbitListener(queues = "notify.payment")
		public class PaymentNotifyReceive {
	    @RabbitHandler
	    public void receive(String msg) {
	        LogUtil.info("notify.payment receive message: "+msg);
	    }
	}

2.3）添加一个消息发送类（生产者）

将消息发送至默认的交换机且routingKey为notify.payment

	@Component
	public class PaymentNotifySender {
    @Autowired
    private AmqpTemplate rabbitTemplate;
     
	    public void sender(String msg){
	        LogUtil.info("notify.payment send message: "+msg);
	        rabbitTemplate.convertAndSend("notify.payment", msg);
	    }
	}

2.4）添加一个测试类（生产者）

	@RunWith(SpringRunner.class)
	@SpringBootTest
	public class PaymentNotifySenderTests {
	    @Autowired
	    private PaymentNotifySender sender;
     
	    @Test
	    public void test_sender() {
	        sender.sender("支付订单号："+System.currentTimeMillis());
	    }
	}

2.5）执行test_sender()方法

生产者日志：

	2022-04-08 14:54:27.771  INFO 56280 --- [           main] c.e.rabbitmqdemo.PaymentNotifySender     : notify.payment send message: 支付订单号：1649400867771

消费者日志：

	2022-04-08 14:54:27.793  INFO 56280 --- [ntContainer#0-1] c.e.rabbitmqdemo.PaymentNotifyReceive    : notify.payment receive message: 支付订单号：1649400867771

分析日志：

从生产者日志可以看出，消息已经成功发送。

从消费者日志可以看出，消息已经成功接收。

## 3.交换机——TopicExchange ##

TopicExchange是按规则转发消息，是交换机中最灵活的一个。也是最常用的一个。

![](https://images2018.cnblogs.com/blog/1308658/201805/1308658-20180515095821882-1047782467.png)

3.1）添加一个配置类（消费者）

配置一个routingKey为api.core的消息队列并绑定在coreExchange交换机上（交换机的匹配规则为api.core.*）

配置一个routingKey为api.payment的消息队列并绑定在paymentExchange交换机上（交换机的匹配规则为api.payment.#）

	@Configuration
	public class TopicConfig {
	    @Bean
	    public Queue coreQueue() {
	        return new Queue("api.core");
	    }
	     
	    @Bean
	    public Queue paymentQueue() {
	        return new Queue("api.payment");
	    }
	     
	    @Bean
	    public TopicExchange coreExchange() {
	        return new TopicExchange("coreExchange");
	    }
	     
	    @Bean
	    public TopicExchange paymentExchange() {
	        return new TopicExchange("paymentExchange");
	    }
	     
	    @Bean
	    public Binding bindingCoreExchange(Queue coreQueue, TopicExchange coreExchange) {
	        return BindingBuilder.bind(coreQueue).to(coreExchange).with("api.core.*");
	    }
	     
	    @Bean
	    public Binding bindingPaymentExchange(Queue paymentQueue, TopicExchange paymentExchange) {
	        return BindingBuilder.bind(paymentQueue).to(paymentExchange).with("api.payment.#");
	    }
	}

3.2）添加两个消息监听类（消费者）

监听routingKey为api.core的队列消息

	@Component
	public class ApiCoreReceive {
	    @RabbitHandler
	    @RabbitListener(queues = "api.core")
	    public void user(String msg) {
	        LogUtil.info("api.core receive message: "+msg);
	    }
	}

监听routingKey为api.payment的队列消息

	@Component
	public class ApiPaymentReceive {
	    @RabbitHandler
	    @RabbitListener(queues = "api.payment")
	    public void order(String msg) {
	        LogUtil.info("api.payment.order receive message: "+msg);
	    }
	}

3.3）添加两个消息发送类（生产者）

添加一个user()方法，发送消息至coreExchange交换机且routingKey为api.core.user

添加一个userQuery()方法，发送消息至coreExchange交换机且routingKey为api.core.user.query

	@Component
	public class ApiCoreSender {
    @Autowired
    private AmqpTemplate rabbitTemplate;
     
	    public void user(String msg){
	        LogUtil.info("api.core.user send message: "+msg);
	        rabbitTemplate.convertAndSend("coreExchange", "api.core.user", msg);
	    }
	     
	    public void userQuery(String msg){
	        LogUtil.info("api.core.user.query send message: "+msg);
	        rabbitTemplate.convertAndSend("coreExchange", "api.core.user.query", msg);
	    }
	}

添加一个order()方法，发送消息至paymentExchange交换机且routingKey为api.payment.order

添加一个orderQuery()方法，发送消息至paymentExchange交换机且routingKey为api.payment.order.query

添加一个orderDetailQuery()方法，发送消息至paymentExchange交换机且routingKey为api.payment.order.detail.query

	@Component
	public class ApiPaymentSender {
	    @Autowired
	    private AmqpTemplate rabbitTemplate;
     
	    public void order(String msg){
	        LogUtil.info("api.payment.order send message: "+msg);
	        rabbitTemplate.convertAndSend("paymentExchange", "api.payment.order", msg);
	    }
	     
	    public void orderQuery(String msg){
	        LogUtil.info("api.payment.order.query send message: "+msg);
	        rabbitTemplate.convertAndSend("paymentExchange", "api.payment.order.query", msg);
	    }
	     
	    public void orderDetailQuery(String msg){
	        LogUtil.info("api.payment.order.detail.query send message: "+msg);
	        rabbitTemplate.convertAndSend("paymentExchange", "api.payment.order.detail.query", msg);
	    }
	}

3.4）添加两个测试类（生产者）

测试ApiCoreSender类中的相关方法

	@RunWith(SpringRunner.class)
	@SpringBootTest
	public class ApiCoreSenderTests {
	    @Autowired
	    private ApiCoreSender sender;
	     
	    @Test
	    public void test_user() {
	        sender.user("用户管理！");
	    }
	     
	    @Test
	    public void test_userQuery() {
	        sender.userQuery("查询用户信息！");
	    }
	}

测试ApiPaymentSender类中的相关方法

	@RunWith(SpringRunner.class)
	@SpringBootTest
	public class ApiPaymentSenderTests {
    @Autowired
    private ApiPaymentSender sender;
     
	    @Test
	    public void test_order() {
	        sender.order("订单管理！");
	    }
	     
	    @Test
	    public void test_orderQuery() {
	        sender.orderQuery("查询订单信息！");
	    }
	     
	    @Test
	    public void test_orderDetailQuery() {
	        sender.orderDetailQuery("查询订单详情信息！");
	    }
	}

3.5）验证

3.5.1）执行ApiCoreSenderTests测试类

生产者日志：

	main] com.lianjinsoft.util.LogUtil             : api.core.user send message: 用户管理！

	main] com.lianjinsoft.util.LogUtil             : api.core.user.query send message: 查询用户信息！

消费者日志：
	
	com.lianjinsoft.util.LogUtil             : api.core receive message: 用户管理！

分析日志：

从生产者日志可以看出，api.core.user和api.core.user.query消息均已发送成功。

从消费者日志可以看出，只有api.core.user发送的消息被收到了。

问题：

为什么api.core.user.query发送的消息没有被api.core队列监听消费？

答：因为在TopicConfig配置类中，我们对api.core队列绑定的交换机规则是api.core.*，而通配符“*”只能向后多匹配一层路径。

 

3.5.2）执行ApiPaymentSenderTests测试类

生产者日志：

	main] com.lianjinsoft.util.LogUtil             : api.payment.order.query send message: 查询订单信息！、
	main] com.lianjinsoft.util.LogUtil             : api.payment.order.detail.query send message: 查询订单详情信息！
	main] com.lianjinsoft.util.LogUtil             : api.payment.order send message: 订单管理！

消费者日志：

	com.lianjinsoft.util.LogUtil             : api.payment.order receive message: 查询订单信息！
	com.lianjinsoft.util.LogUtil             : api.payment.order receive message: 查询订单详情信息！
	com.lianjinsoft.util.LogUtil             : api.payment.order receive message: 订单管理！

分析日志：

从生产者日志第7、10、11行可以看出，api.payment.order.query、api.payment.order.detail.query、api.payment.order消息均发送成功。

从消费者日志可以看出，api.payment.order队列监听到了所有消息并均处理成功了。

知识点：

TopicExchange交换机支持使用通配符*、#

*号只能向后多匹配一层路径。

#号可以向后匹配多层路径。

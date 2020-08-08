package jms;

import Entities.Sensor;
import com.google.gson.Gson;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.concurrent.TimeUnit;

public class Sender {
    public Sender() {

    }

    private static Gson gson = new Gson();
    private static Random random;
    private static Format format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    public static void sendMessage(String topicName) throws JMSException {
        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory("failover:tcp://localhost:61616");

        Connection connection = factory.createConnection("admin", "admin");
        connection.start();

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        Topic topic = session.createTopic(topicName);

        MessageProducer messageProducer = session.createProducer(topic);

        while (true) {
            try {
                TimeUnit.SECONDS.sleep(2);
                random = new Random();
                int id = random.nextInt(2) + 1;
                String reading = newReading(id);
                TextMessage textMessage = session.createTextMessage(reading);
                messageProducer.send(textMessage);
                System.out.println("Sending: " + reading);

            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static String newReading(int id) {
        String date = format.format(new Date());
        double temperature = random.nextInt(90) + 1;
        double humidity = random.nextInt(90) + 1;
        Sensor sensor = new Sensor(id, date, temperature, humidity);
        return gson.toJson(sensor);
    }
}

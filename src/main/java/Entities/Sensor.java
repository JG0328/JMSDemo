package Entities;

public class Sensor {
    private int id;
    private String date;
    private double temperature;
    private double humidity;

    public Sensor() {

    }

    public Sensor(int id, String date, double temperature, double humidity) {
        this.id = id;
        this.date = date;
        this.temperature = temperature;
        this.humidity = humidity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public double getHumidity() {
        return humidity;
    }

    public void setHumidity(double humidity) {
        this.humidity = humidity;
    }
}

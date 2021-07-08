package com.ssm.pojo;

public class Person {
    private Integer Id;
    private String name;
    private Integer age;
    private String sex;
    private IDCard card;

    @Override
    public String toString() {
        return "Person [Id=" + Id + ", name=" + name + ", age=" + age + ", sex=" + sex + ", card=" + card + "]";
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public IDCard getCard() {
        return card;
    }

    public void setCard(IDCard card) {
        this.card = card;
    }
}

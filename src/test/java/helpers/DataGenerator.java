package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
  
  public static String getRandomEmail() {
    Faker faker = new Faker();
    String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
    return email;
  }

  public static String getRandomUsername() {
    Faker faker = new Faker();
    String randomName = faker.name().firstName().toLowerCase();
    return randomName;
  }

  public static String randomComment() {
    Faker faker = new Faker();
    String randomComment = faker.cat().name();
    return randomComment;
  }

  public static JSONObject getRandomArticle() {
    Faker faker = new Faker();
    String title = faker.gameOfThrones().character();
    String description = faker.gameOfThrones().city();
    String body = faker.gameOfThrones().house();
    JSONObject json = new JSONObject();
    json.put("title", title);
    json.put("description", description);
    json.put("body", body);
    return json;
  }

}

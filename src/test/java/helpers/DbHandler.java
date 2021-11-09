package helpers;

import java.sql.*;
import net.minidev.json.JSONObject;
import java.sql.Connection;

public class DbHandler {

  public static void addNewPerson(String personName) {
    try (Connection connect = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/users","root","admin")) {
      connect.createStatement().execute("INSERT INTO persons VALUES (default, '"+personName+"', 40000, 60000)");
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public static JSONObject getSalary(String personName) {
    JSONObject json = new JSONObject();
    try (Connection connect = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/users","root","admin")) {
      ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM persons WHERE name = '"+personName+"'");
      rs.next();
      json.put("minSalary", rs.getString("min_salary"));
      json.put("maxSalary", rs.getString("max_salary"));
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return json;
  }

  
}

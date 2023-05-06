/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package citasIne;

/**
 *
 * @author c-161
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexion {

    public static Connection conexion()
    {
        String connectionUrl
                = "jdbc:sqlserver://CARLOS:1433;"
                + "database=citas_ine;"
                + "user=JOSA;"
                + "password=1234567890;"
                + "encrypt=true;"
                + "trustServerCertificate=TRUE;"
                + "loginTimeout=30;";
        try {
            Connection con=DriverManager.getConnection(connectionUrl);
            return con;
        }catch(SQLException e)
        {
            System.out.println(e.toString());
            return null;
        }
    }
   

    public static void main(String[] args) {
        
        String connectionUrl
                = "jdbc:sqlserver://CARLOS:1433;"
                + "database=citas_ine;"
                + "user=JOSA;"
                + "password=1234567890;"
                + "encrypt=true;"
                + "trustServerCertificate=TRUE;"
                + "loginTimeout=30;";

        ResultSet resultSet = null;

        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {

            // Create and execute a SELECT SQL statement.
            String selectSql = "SELECT TOP 20 nombre, id_estado, id_municipio, nombre FROM municipio";
            resultSet = statement.executeQuery(selectSql);

            // Print results from select statement
            while (resultSet.next()) {
                System.out.println(resultSet.getString(2) + " " + resultSet.getString(3) + " "
                        + resultSet.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
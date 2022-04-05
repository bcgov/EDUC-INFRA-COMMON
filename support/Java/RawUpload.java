package ca.bc.gov.educ.api.digitalid.exception;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RawUpload {
  public static void main(String[] args) throws SQLException, IOException {

    Connection conn = DriverManager.getConnection("<CONNECT STRING>", "<USER>", "<PASSWORD>");
    conn.setAutoCommit(false);
    PreparedStatement stmt1 = conn.prepareStatement("SELECT FILE_BLOB FROM <YOUR TABLE> WHERE FILE_TYPE = 'PEN' AND SUBMISSION_NO = '<YOUR SUB NUMBER>'");
    PreparedStatement stmt2 = conn.prepareStatement("UPDATE <YOUR TABLE> SET FILE_BLOB = ? WHERE FILE_TYPE = 'PEN' AND SUBMISSION_NO = '<YOUR SUB NUMBER>'");

    ResultSet rs = stmt1.executeQuery();

    rs.next();
    byte[] fileText = rs.getBytes(1);
    String string = new String(fileText);
    //Make the changes you need to the file data
    string = string.replaceAll("<WHAT YOU NEED TO REMOVE>", "<YOUR REPLACEMENT>");
    System.out.println(string);
    stmt2.setBytes(1, string.getBytes());

    stmt2.executeUpdate();

    rs.close();
    stmt1.close();
    stmt2.close();

    conn.commit();
    conn.close();
  }
}

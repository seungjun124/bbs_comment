package views;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ViewsDAO {

	public int view(int ID, String userIP) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT INTO VIEWS VALUES(?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			ps.setString(2, userIP);
			return ps.executeUpdate();
		} catch (Exception e) {
//			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int viewDelete(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE VIEWS WHERE ID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
}

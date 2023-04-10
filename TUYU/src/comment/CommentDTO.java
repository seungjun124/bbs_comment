package comment;

public class CommentDTO {
	
	int Division;
	int ID;
	int ID2;
	int ID3;
	String userName;
	String userEmail;
	String userComment;
	String userIP;
	String Day;

	public int getID3() {
		return ID3;
	}
	public void setID3(int iD3) {
		ID3 = iD3;
	}
	public int getDivision() {
		return Division;
	}
	public void setDivision(int division) {
		Division = division;
	}
	public int getID2() {
		return ID2;
	}
	public void setID2(int iD2) {
		ID2 = iD2;
	}
	public String getDay() {
		return Day;
	}
	public void setDay(String day) {
		Day = day;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserComment() {
		return userComment;
	}
	public void setUserComment(String userComment) {
		this.userComment = userComment;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	
}

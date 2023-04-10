package bbs;

public class BbsDTO {
	int ID;
	String Subject;
	String Title;
	String Content;
	String userName;
	String userEmail;
	String Day;
	int Views;
	int Likes;
	String bbsDivide;
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getSubject() {
		return Subject;
	}
	public void setSubject(String subject) {
		Subject = subject;
	}
	public String getTitle() {
		return Title;
	}
	public String getBbsDivide() {
		return bbsDivide;
	}
	public void setBbsDivide(String bbsDivide) {
		this.bbsDivide = bbsDivide;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDay() {
		return Day;
	}
	public void setDay(String day) {
		Day = day;
	}
	public int getViews() {
		return Views;
	}
	public void setViews(int views) {
		Views = views;
	}
	public int getLikes() {
		return Likes;
	}
	public void setLikes(int likes) {
		Likes = likes;
	}
	
}

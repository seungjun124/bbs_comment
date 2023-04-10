package user;

public class UserDTO {
	
	String userName;
	String userEmail;
	String userPW;
	String userEmailHash;
	int userEmailChecked;
	
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
	public String getUserPW() {
		return userPW;
	}
	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public int getUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(int userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	public UserDTO(String userName, String userEmail, String userPW,
			String userEmailHash, int userEmailChecked) {
		super();
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPW = userPW;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
	}
}

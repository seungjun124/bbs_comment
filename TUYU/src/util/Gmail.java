package util;

import javax.mail.*;

public class Gmail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("hy21639@sonline20.sen.go.kr", "zjelfvhshzwwozny");
	}
}

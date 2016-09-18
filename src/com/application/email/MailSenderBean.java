package com.application.email;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSenderBean {
	public void sendMail(String fromEmail, String username, String password, String toEmail, String subject, String message){
		
		java.util.Properties properties = System.getProperties();
		
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.fallback", "false");
		
		Session mailSession = Session.getDefaultInstance(properties, null);
		
		javax.mail.Message mailMessage = new MimeMessage(mailSession);
		
		try {
			mailMessage.setFrom(new InternetAddress(fromEmail));
			mailMessage.setRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(toEmail));
			mailMessage.setContent(message, "text/html");
			mailMessage.setSubject(subject);
			
			Transport transport = mailSession.getTransport("smtp");
			transport.connect("smtp.gmail.com", username, password);
			transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}

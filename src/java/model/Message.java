package model;

import java.sql.Timestamp;

public class Message {

    private int messageId;
    private int senderId;
    private int receiverId;
    private String content;
    private String language;
    private boolean isRead;
    private Timestamp sentTime;

    public Message(int messageId, int senderId, int receiverId, String content, String language, boolean isRead, Timestamp sentTime) {
        this.messageId = messageId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.content = content;
        this.language = language;
        this.isRead = isRead;
        this.sentTime = sentTime;
    }

    public int getMessageId() {
        return messageId;
    }

    public int getSenderId() {
        return senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public String getContent() {
        return content;
    }

    public String getLanguage() {
        return language;
    }

    public boolean isRead() {
        return isRead;
    }

    public Timestamp getSentTime() {
        return sentTime;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public void setSentTime(Timestamp sentTime) {
        this.sentTime = sentTime;
    }

    @Override
    public String toString() {
        return "Message{"
                + "messageId=" + messageId
                + ", senderId=" + senderId
                + ", receiverId=" + receiverId
                + ", content='" + content + '\''
                + ", language='" + language + '\''
                + ", isRead=" + isRead
                + ", sentTime=" + sentTime
                + '}';
    }
}

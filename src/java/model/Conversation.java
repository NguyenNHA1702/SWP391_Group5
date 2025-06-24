package model;

public class Conversation {

    private int otherUserId;
    private String otherUsername;
    private int unreadCount;

    public Conversation(int otherUserId, String otherUsername, int unreadCount) {
        this.otherUserId = otherUserId;
        this.otherUsername = otherUsername;
        this.unreadCount = unreadCount;
    }

    public int getOtherUserId() {
        return otherUserId;
    }

    public String getOtherUsername() {
        return otherUsername;
    }

    public int getUnreadCount() {
        return unreadCount;
    }

    public void setOtherUserId(int otherUserId) {
        this.otherUserId = otherUserId;
    }

    public void setOtherUsername(String otherUsername) {
        this.otherUsername = otherUsername;
    }

    public void setUnreadCount(int unreadCount) {
        this.unreadCount = unreadCount;
    }

    @Override
    public String toString() {
        return "Conversation{"
                + "otherUserId=" + otherUserId
                + ", otherUsername='" + otherUsername + '\''
                + ", unreadCount=" + unreadCount
                + '}';
    }
}

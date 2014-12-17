package hello;

public class Sales {
    public String role = "";
    public String channel = "";
    public boolean isActive = true;
    public boolean showAllProducts = false;
    public boolean showOasActivity = false;
    public boolean showNewBusiness = false;
    public boolean showUserList = false;
    public boolean showCsProducts = false;
    public boolean showCommissionInfo = false;

    public Sales(String role, String channel, boolean isActive) {
        this.role = role;
        this.channel = channel;
        this.isActive = isActive;
    }

    public void setShowAllProducts(boolean val) {
        this.showAllProducts = val;
    }

    public void setShowOasActivity(boolean val) {
        this.showOasActivity = val;
    }

    public void setShowNewBusiness(boolean val) {
        this.showNewBusiness = val;
    }

    public void setShowUserList(boolean val) {
        this.showUserList = val;
    }

    public void setShowCsProducts(boolean val) {
        this.showCsProducts = val;
    }

    public void setShowCommissionInfo(boolean val) {
        this.showCommissionInfo = val;
    }
}
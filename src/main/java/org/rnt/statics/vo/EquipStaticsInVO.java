package org.rnt.statics.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipStaticsInVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 6216375338911213782L;
    private String searchBaseYear;
    private String searchCompYear;
    private String searchMonth;
    private String searchMonth1;
    private String searchMonth2;
    private String searchStandardMonth;
    private String searchStandardMonth1;
    private String searchStandardMonth2;
    public String getSearchBaseYear() {
        return searchBaseYear;
    }
    public void setSearchBaseYear(String searchBaseYear) {
        this.searchBaseYear = searchBaseYear;
    }
    public String getSearchCompYear() {
        return searchCompYear;
    }
    public void setSearchCompYear(String searchCompYear) {
        this.searchCompYear = searchCompYear;
    }
    public String getSearchMonth() {
        return searchMonth;
    }
    public void setSearchMonth(String searchMonth) {
        this.searchMonth = searchMonth;
    }
    public String getSearchMonth1() {
        return searchMonth1;
    }
    public void setSearchMonth1(String searchMonth1) {
        this.searchMonth1 = searchMonth1;
    }
    public String getSearchMonth2() {
        return searchMonth2;
    }
    public void setSearchMonth2(String searchMonth2) {
        this.searchMonth2 = searchMonth2;
    }
    public String getSearchStandardMonth() {
        return searchStandardMonth;
    }
    public void setSearchStandardMonth(String searchStandardMonth) {
        this.searchStandardMonth = searchStandardMonth;
    }
    public String getSearchStandardMonth1() {
        return searchStandardMonth1;
    }
    public void setSearchStandardMonth1(String searchStandardMonth1) {
        this.searchStandardMonth1 = searchStandardMonth1;
    }
    public String getSearchStandardMonth2() {
        return searchStandardMonth2;
    }
    public void setSearchStandardMonth2(String searchStandardMonth2) {
        this.searchStandardMonth2 = searchStandardMonth2;
    }
    
    
}

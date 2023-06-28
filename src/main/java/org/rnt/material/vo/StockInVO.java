package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class StockInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316275218901013782L;
	private String searchMatCd;
	private String searchWorkshopCd;
	private String sbDt;

    public String getSbDt() {
		return sbDt;
	}
	public void setSbDt(String sbDt) {
		this.sbDt = sbDt;
	}
	public String getSearchMatCd() {
        return searchMatCd;
    }
    public void setSearchMatCd(String searchMatCd) {
        this.searchMatCd = searchMatCd;
    }
    public String getSearchWorkshopCd() {
        return searchWorkshopCd;
    }
    public void setSearchWorkshopCd(String searchWorkshopCd) {
        this.searchWorkshopCd = searchWorkshopCd;
    }
}

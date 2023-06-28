package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class SubulInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316175218901013382L;
	private String searchWorkshopCd;

	public String getSearchWorkshopCd() {
        return searchWorkshopCd;
    }
    public void setSearchWorkshopCd(String searchWorkshopCd) {
        this.searchWorkshopCd = searchWorkshopCd;
    }
}

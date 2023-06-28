package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class LotTrackingVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String lotDiv;
	private String searchLotId;

	public String getSearchLotId() {
		return searchLotId;
	}

	public void setSearchLotId(String searchLotId) {
		this.searchLotId = searchLotId;
	}

	public String getLotDiv() {
		return lotDiv;
	}

	public void setLotDiv(String lotDiv) {
		this.lotDiv = lotDiv;
	}
	
}

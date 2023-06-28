package org.rnt.dashboard.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DashboardProductionChartVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316375213901013782L;
	private String equipCd;        
	private String equipNm;  
	private Integer actokQty;
	private Integer actbadQty;
	
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public String getEquipNm() {
		return equipNm;
	}
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	public Integer getActokQty() {
		return actokQty;
	}
	public void setActokQty(Integer actokQty) {
		this.actokQty = actokQty;
	}
	public Integer getActbadQty() {
		return actbadQty;
	}
	public void setActbadQty(Integer actbadQty) {
		this.actbadQty = actbadQty;
	}
	
}


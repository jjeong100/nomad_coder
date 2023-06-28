package org.rnt.dashboard.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DashboardEquipSumVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316375213901013782L;
	private String nowDay;
	private String nowTime;        
	private String totPoQty;  
	private String totActokQty;  
	private String totActbadQty;  
	private String actokRate;  
	private String actbadRate;
	
	public String getNowDay() {
		return nowDay;
	}
	public void setNowDay(String nowDay) {
		this.nowDay = nowDay;
	}
	public String getNowTime() {
		return nowTime;
	}
	public void setNowTime(String nowTime) {
		this.nowTime = nowTime;
	}
	public String getTotPoQty() {
		return totPoQty;
	}
	public void setTotPoQty(String totPoQty) {
		this.totPoQty = totPoQty;
	}
	public String getTotActokQty() {
		return totActokQty;
	}
	public void setTotActokQty(String totActokQty) {
		this.totActokQty = totActokQty;
	}
	public String getTotActbadQty() {
		return totActbadQty;
	}
	public void setTotActbadQty(String totActbadQty) {
		this.totActbadQty = totActbadQty;
	}
	public String getActokRate() {
		return actokRate;
	}
	public void setActokRate(String actokRate) {
		this.actokRate = actokRate;
	}
	public String getActbadRate() {
		return actbadRate;
	}
	public void setActbadRate(String actbadRate) {
		this.actbadRate = actbadRate;
	}  
	
	
}


package org.rnt.dashboard.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DashboardOndoChartVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316375213901013782L;
	private String hour;        
	private Double ondo1;  
	private Double ondo2;  
	private Double ondo3;  
	private Double ondo4;
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public Double getOndo1() {
		return ondo1;
	}
	public void setOndo1(Double ondo1) {
		this.ondo1 = ondo1;
	}
	public Double getOndo2() {
		return ondo2;
	}
	public void setOndo2(Double ondo2) {
		this.ondo2 = ondo2;
	}
	public Double getOndo3() {
		return ondo3;
	}
	public void setOndo3(Double ondo3) {
		this.ondo3 = ondo3;
	}
	public Double getOndo4() {
		return ondo4;
	}
	public void setOndo4(Double ondo4) {
		this.ondo4 = ondo4;
	}
	
	
}


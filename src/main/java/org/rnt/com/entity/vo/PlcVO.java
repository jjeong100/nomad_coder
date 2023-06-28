package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class PlcVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 3940959589721917612L;
	
	private String plcCd;
	private String plcTypeCd;
	private String plcStatusCd;
	private String prodSeq;
	private String data1;
	private String data2;
	private String data3;
	
	public String getPlcCd() {
		return plcCd;
	}
	public void setPlcCd(String plcCd) {
		this.plcCd = plcCd;
	}
	public String getPlcTypeCd() {
		return plcTypeCd;
	}
	public void setPlcTypeCd(String plcTypeCd) {
		this.plcTypeCd = plcTypeCd;
	}
	public String getPlcStatusCd() {
		return plcStatusCd;
	}
	public void setPlcStatusCd(String plcStatusCd) {
		this.plcStatusCd = plcStatusCd;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getData1() {
		return data1;
	}
	public void setData1(String data1) {
		this.data1 = data1;
	}
	public String getData2() {
		return data2;
	}
	public void setData2(String data2) {
		this.data2 = data2;
	}
	public String getData3() {
		return data3;
	}
	public void setData3(String data3) {
		this.data3 = data3;
	}

}

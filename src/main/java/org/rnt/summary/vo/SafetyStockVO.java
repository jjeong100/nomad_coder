package org.rnt.summary.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class SafetyStockVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	private String searchItemMaterialType;
	private String searchLackAllType;
	private String matCd;
	private String nmType;
	private String matNm;
	private Integer safeStockQty;
	private double totQty;
	public String getSearchItemMaterialType() {
		return searchItemMaterialType;
	}
	public void setSearchItemMaterialType(String searchItemMaterialType) {
		this.searchItemMaterialType = searchItemMaterialType;
	}
	public String getSearchLackAllType() {
		return searchLackAllType;
	}
	public void setSearchLackAllType(String searchLackAllType) {
		this.searchLackAllType = searchLackAllType;
	}
	public String getMatCd() {
		return matCd;
	}
	public void setMatCd(String matCd) {
		this.matCd = matCd;
	}
	public String getNmType() {
		return nmType;
	}
	public void setNmType(String nmType) {
		this.nmType = nmType;
	}
	public String getMatNm() {
		return matNm;
	}
	public void setMatNm(String matNm) {
		this.matNm = matNm;
	}
	public Integer getSafeStockQty() {
		return safeStockQty;
	}
	public void setSafeStockQty(Integer safeStockQty) {
		this.safeStockQty = safeStockQty;
	}
	public double getTotQty() {
		return totQty;
	}
	public void setTotQty(double totQty) {
		this.totQty = totQty;
	}
	
}

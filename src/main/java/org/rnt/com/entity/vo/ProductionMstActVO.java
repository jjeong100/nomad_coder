package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductionMstActVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 4313743899935852649L;
	private String factoryCd;
	private String workactMstSeq;
	private String prodSeq;
	private String operCd;
	private String operNm;
	private Integer operLvl;
	private String itemCd;
	private String itemNm;
	private Integer limitAssignQty;
	private Integer assignQty;
	private Integer workQty;
	private Integer actokQty;
	private Integer actbadQty;
	private Integer lossQty;
	private Integer confirmQty;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
    // add
	private String operAuthYn;
	private String searchLoginId;
	private String searchProdSeq;
	private String workactTypeCd;
	private String statusCd;
	private String upProdSeq;
	private String workactSeq;
	private String safeStockYn;
	private Integer safeStockQty;
	private String outcustYn;
	private String custCd;
	private String custNm;
	
    public String getWorkactSeq() {
        return workactSeq;
    }
    public void setWorkactSeq(String workactSeq) {
        this.workactSeq = workactSeq;
    }
    public String getUpProdSeq() {
        return upProdSeq;
    }
    public void setUpProdSeq(String upProdSeq) {
        this.upProdSeq = upProdSeq;
    }
    public String getStatusCd() {
        return statusCd;
    }
    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getWorkactMstSeq() {
        return workactMstSeq;
    }
    public void setWorkactMstSeq(String workactMstSeq) {
        this.workactMstSeq = workactMstSeq;
    }
    public String getProdSeq() {
        return prodSeq;
    }
    public void setProdSeq(String prodSeq) {
        this.prodSeq = prodSeq;
    }
    public String getOperCd() {
        return operCd;
    }
    public void setOperCd(String operCd) {
        this.operCd = operCd;
    }
    public String getOperNm() {
        return operNm;
    }
    public void setOperNm(String operNm) {
        this.operNm = operNm;
    }
    public Integer getOperLvl() {
        return operLvl;
    }
    public void setOperLvl(Integer operLvl) {
        this.operLvl = operLvl;
    }
    public String getItemCd() {
        return itemCd;
    }
    public void setItemCd(String itemCd) {
        this.itemCd = itemCd;
    }
    public String getItemNm() {
        return itemNm;
    }
    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }
    public Integer getLimitAssignQty() {
		return limitAssignQty;
	}
	public void setLimitAssignQty(Integer limitAssignQty) {
		this.limitAssignQty = limitAssignQty;
	}
	public Integer getAssignQty() {
        return assignQty;
    }
    public void setAssignQty(Integer assignQty) {
        this.assignQty = assignQty;
    }
    public Integer getWorkQty() {
        return workQty;
    }
    public void setWorkQty(Integer workQty) {
        this.workQty = workQty;
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
    public Integer getLossQty() {
		return lossQty;
	}
	public void setLossQty(Integer lossQty) {
		this.lossQty = lossQty;
	}
	public Integer getConfirmQty() {
        return confirmQty;
    }
    public void setConfirmQty(Integer confirmQty) {
        this.confirmQty = confirmQty;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public java.util.Date getWriteDt() {
        return writeDt;
    }
    public void setWriteDt(java.util.Date writeDt) {
        this.writeDt = writeDt;
    }
    public String getWriteId() {
        return writeId;
    }
    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }
    public java.util.Date getUpdateDt() {
        return updateDt;
    }
    public void setUpdateDt(java.util.Date updateDt) {
        this.updateDt = updateDt;
    }
    public String getUpdateId() {
        return updateId;
    }
    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }
    public String getOperAuthYn() {
        return operAuthYn;
    }
    public void setOperAuthYn(String operAuthYn) {
        this.operAuthYn = operAuthYn;
    }
    public String getSearchLoginId() {
        return searchLoginId;
    }
    public void setSearchLoginId(String searchLoginId) {
        this.searchLoginId = searchLoginId;
    }
    public String getSearchProdSeq() {
        return searchProdSeq;
    }
    public void setSearchProdSeq(String searchProdSeq) {
        this.searchProdSeq = searchProdSeq;
    }
	public String getWorkactTypeCd() {
		return workactTypeCd;
	}
	public void setWorkactTypeCd(String workactTypeCd) {
		this.workactTypeCd = workactTypeCd;
	}
	public String getSafeStockYn() {
		return safeStockYn;
	}
	public void setSafeStockYn(String safeStockYn) {
		this.safeStockYn = safeStockYn;
	}
	public Integer getSafeStockQty() {
		return safeStockQty;
	}
	public void setSafeStockQty(Integer safeStockQty) {
		this.safeStockQty = safeStockQty;
	}
	public String getOutcustYn() {
		return outcustYn;
	}
	public void setOutcustYn(String outcustYn) {
		this.outcustYn = outcustYn;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
}

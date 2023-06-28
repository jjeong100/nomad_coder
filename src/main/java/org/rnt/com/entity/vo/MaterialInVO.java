package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MaterialInVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 3940959589721917612L;

    private String factoryCd;
	private String matinSeq;
	private String inDt;
	private String matInTypeCd;
	private String matInTypeNm;
	private String workshopCd;
	private String workshopNm;
	private String custCd;
	private String custNm;
	private String matCd;
	private String matNm;
	private String matTypeCd;
	private String matTypeNm;
	private Double inCnt;
	private Double outCnt;
	private Double stockQty;
	private String lotid;
	private String outSocSeq;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String writeNm;

	private String matItemNm;
	private String writeDtStr;
	private String matItemTypeCd;
	private String matItemTypeNm;
    private String searchWorkshopCd;
    private String searchWorkshopNm;
    private String searchCustCd;
    private String searchCustNm;
    private String searchLotid;
    private String searchMatCd;
    private String searchMatNm;
    private String searchStockYn;
    private String searchProdSeq;
    private String matGrpNm;


	public String getMatItemNm() {
		return matItemNm;
	}
	public void setMatItemNm(String matItemNm) {
		this.matItemNm = matItemNm;
	}
	public String getWriteDtStr() {
		return writeDtStr;
	}
	public void setWriteDtStr(String writeDtStr) {
		this.writeDtStr = writeDtStr;
	}
	public String getWriteNm() {
		return writeNm;
	}
	public void setWriteNm(String writeNm) {
		this.writeNm = writeNm;
	}
	public String getMatGrpNm() {
		return matGrpNm;
	}
	public void setMatGrpNm(String matGrpNm) {
		this.matGrpNm = matGrpNm;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getMatinSeq() {
		return matinSeq;
	}
	public void setMatinSeq(String matinSeq) {
		this.matinSeq = matinSeq;
	}
	public String getInDt() {
		return inDt;
	}
	public void setInDt(String inDt) {
		this.inDt = inDt;
	}
	public String getMatInTypeCd() {
		return matInTypeCd;
	}
	public void setMatInTypeCd(String matInTypeCd) {
		this.matInTypeCd = matInTypeCd;
	}
	public String getMatInTypeNm() {
		return matInTypeNm;
	}
	public void setMatInTypeNm(String matInTypeNm) {
		this.matInTypeNm = matInTypeNm;
	}
	public String getWorkshopCd() {
		return workshopCd;
	}
	public void setWorkshopCd(String workshopCd) {
		this.workshopCd = workshopCd;
	}
	public String getWorkshopNm() {
		return workshopNm;
	}
	public void setWorkshopNm(String workshopNm) {
		this.workshopNm = workshopNm;
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
	public String getMatCd() {
		return matCd;
	}
	public void setMatCd(String matCd) {
		this.matCd = matCd;
	}
	public String getMatNm() {
		return matNm;
	}
	public void setMatNm(String matNm) {
		this.matNm = matNm;
	}
	public String getMatTypeCd() {
		return matTypeCd;
	}
	public void setMatTypeCd(String matTypeCd) {
		this.matTypeCd = matTypeCd;
	}
	public String getMatTypeNm() {
		return matTypeNm;
	}
	public void setMatTypeNm(String matTypeNm) {
		this.matTypeNm = matTypeNm;
	}

	public Double getInCnt() {
		return inCnt;
	}
	public void setInCnt(Double inCnt) {
		this.inCnt = inCnt;
	}
	public Double getOutCnt() {
		return outCnt;
	}
	public void setOutCnt(Double outCnt) {
		this.outCnt = outCnt;
	}
	public Double getStockQty() {
		return stockQty;
	}
	public void setStockQty(Double stockQty) {
		this.stockQty = stockQty;
	}
	public String getLotid() {
		return lotid;
	}
	public void setLotid(String lotid) {
		this.lotid = lotid;
	}
	public String getOutSocSeq() {
		return outSocSeq;
	}
	public void setOutSocSeq(String outSocSeq) {
		this.outSocSeq = outSocSeq;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
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
	public String getMatItemTypeCd() {
		return matItemTypeCd;
	}
	public void setMatItemTypeCd(String matItemTypeCd) {
		this.matItemTypeCd = matItemTypeCd;
	}
	public String getMatItemTypeNm() {
		return matItemTypeNm;
	}
	public void setMatItemTypeNm(String matItemTypeNm) {
		this.matItemTypeNm = matItemTypeNm;
	}
	public String getSearchWorkshopCd() {
		return searchWorkshopCd;
	}
	public void setSearchWorkshopCd(String searchWorkshopCd) {
		this.searchWorkshopCd = searchWorkshopCd;
	}
	public String getSearchWorkshopNm() {
		return searchWorkshopNm;
	}
	public void setSearchWorkshopNm(String searchWorkshopNm) {
		this.searchWorkshopNm = searchWorkshopNm;
	}
	public String getSearchCustCd() {
		return searchCustCd;
	}
	public void setSearchCustCd(String searchCustCd) {
		this.searchCustCd = searchCustCd;
	}
	public String getSearchCustNm() {
		return searchCustNm;
	}
	public void setSearchCustNm(String searchCustNm) {
		this.searchCustNm = searchCustNm;
	}
	public String getSearchLotid() {
		return searchLotid;
	}
	public void setSearchLotid(String searchLotid) {
		this.searchLotid = searchLotid;
	}
	public String getSearchMatCd() {
		return searchMatCd;
	}
	public void setSearchMatCd(String searchMatCd) {
		this.searchMatCd = searchMatCd;
	}
	public String getSearchMatNm() {
		return searchMatNm;
	}
	public void setSearchMatNm(String searchMatNm) {
		this.searchMatNm = searchMatNm;
	}
	public String getSearchStockYn() {
		return searchStockYn;
	}
	public void setSearchStockYn(String searchStockYn) {
		this.searchStockYn = searchStockYn;
	}
	public String getSearchProdSeq() {
		return searchProdSeq;
	}
	public void setSearchProdSeq(String searchProdSeq) {
		this.searchProdSeq = searchProdSeq;
	}
}

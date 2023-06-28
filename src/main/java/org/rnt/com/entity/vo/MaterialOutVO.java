package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MaterialOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 3408472864635898887L;

	private String factoryCd;
	private String matoutSeq;
	private String workshopCd;
	private String workshopNm;
	private String prodSeq;
	private String matOutTypeCd;
	private String matOutTypeNm;
	private String outDt;
	private String matCd;
	private String matNm;
	private String lenVal;
	private Double outCnt;
	private String lotid;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	private String matItemTypeCd;
	private String matItemTypeNm;

	private Double stockQty;
	private Double inCnt;
	private Integer poQty;

	// add
    private String searchWorkshopCd;
    private String searchMatOutTypeCd;
    private String searchCustCd;
    private String searchMatCd;
    private String searchMatNm;
    private String searchProdSeqNull;

    private String requireQty;
    private String requireCnt;
    private String requireOutCnt;
    private String matTypeCd;
    private String matGrpNm;



	public Double getInCnt() {
		return inCnt;
	}
	public void setInCnt(Double inCnt) {
		this.inCnt = inCnt;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getMatoutSeq() {
		return matoutSeq;
	}
	public void setMatoutSeq(String matoutSeq) {
		this.matoutSeq = matoutSeq;
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
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getMatOutTypeCd() {
		return matOutTypeCd;
	}
	public void setMatOutTypeCd(String matOutTypeCd) {
		this.matOutTypeCd = matOutTypeCd;
	}
	public String getMatOutTypeNm() {
		return matOutTypeNm;
	}
	public void setMatOutTypeNm(String matOutTypeNm) {
		this.matOutTypeNm = matOutTypeNm;
	}
	public String getOutDt() {
		return outDt;
	}
	public void setOutDt(String outDt) {
		this.outDt = outDt;
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
	public String getLenVal() {
		return lenVal;
	}
	public void setLenVal(String lenVal) {
		this.lenVal = lenVal;
	}
	public Double getOutCnt() {
		return outCnt;
	}
	public void setOutCnt(Double outCnt) {
		this.outCnt = outCnt;
	}
	public String getLotid() {
		return lotid;
	}
	public void setLotid(String lotid) {
		this.lotid = lotid;
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
	public Double getStockQty() {
		return stockQty;
	}
	public void setStockQty(Double stockQty) {
		this.stockQty = stockQty;
	}
	public Integer getPoQty() {
		return poQty;
	}
	public void setPoQty(Integer poQty) {
		this.poQty = poQty;
	}
	public String getSearchWorkshopCd() {
		return searchWorkshopCd;
	}
	public void setSearchWorkshopCd(String searchWorkshopCd) {
		this.searchWorkshopCd = searchWorkshopCd;
	}
	public String getSearchMatOutTypeCd() {
		return searchMatOutTypeCd;
	}
	public void setSearchMatOutTypeCd(String searchMatOutTypeCd) {
		this.searchMatOutTypeCd = searchMatOutTypeCd;
	}
	public String getSearchCustCd() {
		return searchCustCd;
	}
	public void setSearchCustCd(String searchCustCd) {
		this.searchCustCd = searchCustCd;
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
	public String getSearchProdSeqNull() {
		return searchProdSeqNull;
	}
	public void setSearchProdSeqNull(String searchProdSeqNull) {
		this.searchProdSeqNull = searchProdSeqNull;
	}
	public String getRequireQty() {
		return requireQty;
	}
	public void setRequireQty(String requireQty) {
		this.requireQty = requireQty;
	}
	public String getRequireCnt() {
		return requireCnt;
	}
	public void setRequireCnt(String requireCnt) {
		this.requireCnt = requireCnt;
	}
	public String getRequireOutCnt() {
		return requireOutCnt;
	}
	public void setRequireOutCnt(String requireOutCnt) {
		this.requireOutCnt = requireOutCnt;
	}
	public String getMatTypeCd() {
		return matTypeCd;
	}
	public void setMatTypeCd(String matTypeCd) {
		this.matTypeCd = matTypeCd;
	}
	public String getMatGrpNm() {
		return matGrpNm;
	}
	public void setMatGrpNm(String matGrpNm) {
		this.matGrpNm = matGrpNm;
	}

}

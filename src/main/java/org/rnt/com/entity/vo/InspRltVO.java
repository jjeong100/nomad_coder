package org.rnt.com.entity.vo;
import java.io.Serializable;
import java.util.List;

import org.rnt.com.vo.SearchDefaultVO;

public class InspRltVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 3103341078577565022L;
    private String factoryCd;
    private String inspSeq;
    private String workactSeq;
    private int inspDaySeq;
    private String inspTypeCd;
    private String inspSmeCd;
    private String inspSmeNm;
    private String inspItemCd;
    private String inspItemNm;
    private Double measureVal;
    private String inspRltCd;
    private String inspDt;
    private String inspWorkDay;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    private Double highVal;
    private Double lowVal;
    
    private String inspItemTypeCd;
    private String inspDanwiCd;
    private String inspDanwiNm;
    
    private String searchPoCalldt;
    private String searchInspTypeCd;
    private String searchWorkactSeq;
    private String searchInspSmeCd;
    
    private List<InspRltVO> objList;
    
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getInspSeq() {
		return inspSeq;
	}
	public void setInspSeq(String inspSeq) {
		this.inspSeq = inspSeq;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public int getInspDaySeq() {
		return inspDaySeq;
	}
	public void setInspDaySeq(int inspDaySeq) {
		this.inspDaySeq = inspDaySeq;
	}
	public String getInspTypeCd() {
		return inspTypeCd;
	}
	public void setInspTypeCd(String inspTypeCd) {
		this.inspTypeCd = inspTypeCd;
	}
	public String getInspSmeCd() {
		return inspSmeCd;
	}
	public void setInspSmeCd(String inspSmeCd) {
		this.inspSmeCd = inspSmeCd;
	}
	public String getInspSmeNm() {
		return inspSmeNm;
	}
	public void setInspSmeNm(String inspSmeNm) {
		this.inspSmeNm = inspSmeNm;
	}
	public String getInspItemCd() {
		return inspItemCd;
	}
	public void setInspItemCd(String inspItemCd) {
		this.inspItemCd = inspItemCd;
	}
	public String getInspItemNm() {
		return inspItemNm;
	}
	public void setInspItemNm(String inspItemNm) {
		this.inspItemNm = inspItemNm;
	}
	public Double getMeasureVal() {
		return measureVal;
	}
	public void setMeasureVal(Double measureVal) {
		this.measureVal = measureVal;
	}
	public String getInspRltCd() {
		return inspRltCd;
	}
	public void setInspRltCd(String inspRltCd) {
		this.inspRltCd = inspRltCd;
	}
	public String getInspDt() {
		return inspDt;
	}
	public void setInspDt(String inspDt) {
		this.inspDt = inspDt;
	}
	public String getInspWorkDay() {
		return inspWorkDay;
	}
	public void setInspWorkDay(String inspWorkDay) {
		this.inspWorkDay = inspWorkDay;
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
	public Double getHighVal() {
		return highVal;
	}
	public void setHighVal(Double highVal) {
		this.highVal = highVal;
	}
	public Double getLowVal() {
		return lowVal;
	}
	public void setLowVal(Double lowVal) {
		this.lowVal = lowVal;
	}
	public String getInspItemTypeCd() {
		return inspItemTypeCd;
	}
	public void setInspItemTypeCd(String inspItemTypeCd) {
		this.inspItemTypeCd = inspItemTypeCd;
	}
	public String getInspDanwiCd() {
		return inspDanwiCd;
	}
	public void setInspDanwiCd(String inspDanwiCd) {
		this.inspDanwiCd = inspDanwiCd;
	}
	public String getInspDanwiNm() {
		return inspDanwiNm;
	}
	public void setInspDanwiNm(String inspDanwiNm) {
		this.inspDanwiNm = inspDanwiNm;
	}
	public String getSearchPoCalldt() {
		return searchPoCalldt;
	}
	public void setSearchPoCalldt(String searchPoCalldt) {
		this.searchPoCalldt = searchPoCalldt;
	}
	public String getSearchInspTypeCd() {
		return searchInspTypeCd;
	}
	public void setSearchInspTypeCd(String searchInspTypeCd) {
		this.searchInspTypeCd = searchInspTypeCd;
	}
	public String getSearchWorkactSeq() {
		return searchWorkactSeq;
	}
	public void setSearchWorkactSeq(String searchWorkactSeq) {
		this.searchWorkactSeq = searchWorkactSeq;
	}
	public String getSearchInspSmeCd() {
		return searchInspSmeCd;
	}
	public void setSearchInspSmeCd(String searchInspSmeCd) {
		this.searchInspSmeCd = searchInspSmeCd;
	}
	public List<InspRltVO> getObjList() {
		return objList;
	}
	public void setObjList(List<InspRltVO> objList) {
		this.objList = objList;
	}
}

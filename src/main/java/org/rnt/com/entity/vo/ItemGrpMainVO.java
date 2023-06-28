package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ItemGrpMainVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 2650584500123094776L;
	private String factoryCd;
	private String matgpCd;
	private String matgpNm;
	private String bigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeDtStr;
	private String writeId;
	private String writeNm;
	private java.util.Date updateDt;
	private String updateId;
	
	private String searchMatgpNm;
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getMatgpCd() {
		return matgpCd;
	}
	public void setMatgpCd(String matgpCd) {
		this.matgpCd = matgpCd;
	}
	public String getMatgpNm() {
		return matgpNm;
	}
	public void setMatgpNm(String matgpNm) {
		this.matgpNm = matgpNm;
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
	public String getWriteDtStr() {
		return writeDtStr;
	}
	public void setWriteDtStr(String writeDtStr) {
		this.writeDtStr = writeDtStr;
	}
	public String getWriteId() {
		return writeId;
	}
	public void setWriteId(String writeId) {
		this.writeId = writeId;
	}
	public String getWriteNm() {
		return writeNm;
	}
	public void setWriteNm(String writeNm) {
		this.writeNm = writeNm;
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
	public String getSearchMatgpNm() {
		return searchMatgpNm;
	}
	public void setSearchMatgpNm(String searchMatgpNm) {
		this.searchMatgpNm = searchMatgpNm;
	}
}

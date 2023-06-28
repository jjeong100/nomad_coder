package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DocumentVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 5221214831872329685L;
	private String factoryCd;
	private String docSeq;
	private String docNm;
	private String docOrgNm;
	private String docTypeCd;
	private String docFilePath;
	private String docBigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getDocSeq() {
		return docSeq;
	}
	public void setDocSeq(String docSeq) {
		this.docSeq = docSeq;
	}
	public String getDocNm() {
		return docNm;
	}
	public void setDocNm(String docNm) {
		this.docNm = docNm;
	}
	public String getDocOrgNm() {
		return docOrgNm;
	}
	public void setDocOrgNm(String docOrgNm) {
		this.docOrgNm = docOrgNm;
	}
	public String getDocTypeCd() {
		return docTypeCd;
	}
	public void setDocTypeCd(String docTypeCd) {
		this.docTypeCd = docTypeCd;
	}
	public String getDocFilePath() {
		return docFilePath;
	}
	public void setDocFilePath(String docFilePath) {
		this.docFilePath = docFilePath;
	}
	public String getDocBigo() {
		return docBigo;
	}
	public void setDocBigo(String docBigo) {
		this.docBigo = docBigo;
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
}

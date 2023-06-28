package org.rnt.doc.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DocVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String factoryCd;
	private String docSeq;
	private String docNm;
	private String docOrgNm;
	private String docTypeCd;
	private String docFilePath;
	private String docBigo;
	private String useYn;
	private String writeDate;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	private String searchDocNm;
	private String searchDocTypeCd;
	
	
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
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
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
	public String getSearchDocNm() {
		return searchDocNm;
	}
	public void setSearchDocNm(String searchDocNm) {
		this.searchDocNm = searchDocNm;
	}
	public String getSearchDocTypeCd() {
		return searchDocTypeCd;
	}
	public void setSearchDocTypeCd(String searchDocTypeCd) {
		this.searchDocTypeCd = searchDocTypeCd;
	}
	
}

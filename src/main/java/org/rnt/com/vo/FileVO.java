package org.rnt.com.vo;

import java.io.Serializable;

public class FileVO implements Serializable {

	private static final long serialVersionUID = 8034541936653077946L;
	
	private String fileSeq;
	private String fileKey;
	private String fileNm;
	private String fileOrgNm;
	private String filePath;
	private String fileType;
	private long fileSize;
	
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFileKey() {
		return fileKey;
	}
	public void setFileKey(String fileKey) {
		this.fileKey = fileKey;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFileOrgNm() {
		return fileOrgNm;
	}
	public void setFileOrgNm(String fileOrgNm) {
		this.fileOrgNm = fileOrgNm;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
}

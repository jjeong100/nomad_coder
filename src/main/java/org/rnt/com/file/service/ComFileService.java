package org.rnt.com.file.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.rnt.com.file.vo.ComFileVO;
import org.rnt.com.vo.RtnVO;

public interface ComFileService {
	public RtnVO insert(ComFileVO param);
	public RtnVO select(ComFileVO param);
	public RtnVO update(ComFileVO param);
	public RtnVO delete(ComFileVO param);
	public RtnVO selectList(ComFileVO param);
	public RtnVO selectListTotCnt(ComFileVO param);
	public void setFileUpload(HttpServletRequest request, String fileKey, RtnVO rtnVo) throws ServletException, IOException, Exception;
}

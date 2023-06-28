package org.rnt.doc.service;

import org.rnt.com.vo.RtnVO;
import org.rnt.doc.vo.DocVO;

public interface DocService {
    //-------------------------------------------------------------------------
    // 성적서 : searchDocList
    //-------------------------------------------------------------------------
	public RtnVO searchDocList(DocVO param);
	public RtnVO searchDocListTotCnt(DocVO param);
	public RtnVO insert(DocVO param);
	public RtnVO delete(DocVO param);
	
}

package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ResetVO;
import org.rnt.com.vo.RtnVO;

public interface ResetService {
    public RtnVO updateTable(ResetVO param,String queryId);
    public RtnVO deleteTable(ResetVO param,String queryId);
    public RtnVO selectTable(ResetVO param);
    public int selectTable(String tableName);
    public RtnVO insert(ResetVO param);
    public RtnVO searchList(ResetVO param);
}

package org.rnt.com.vo;

import java.io.Serializable;

import org.rnt.com.util.DateUtil;


public class SearchDefaultVO implements Serializable {

    private static final long serialVersionUID = 5052775954515811258L;

    /** 검색조건 */
    private String searchCondition = "";

    /** 검색Keyword */
    private String searchKeyword = "";

    /** 검색조건 시작일 */
    private String  searchFromDate = "";

    /** 검색조건 종료일 */
    private String  searchToDate = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;
    
    private String sortCol;
    private String sortType = "asc"; // asc, desc

    /** firstIndex */
    private int firstIndex = 0;

    /** lastIndex */
    private int lastIndex = 1;
    
    private Long rnum;
    private int startPage = 1;
    private int endPage = 10;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private boolean isPaging = false;
    
    private String crudType = "R";
    
    private String toDay = DateUtil.formatCurrent("yyyy/MM/dd");
    
    public String getToDay() {
        return toDay;
    }

    public void setToDay(String toDay) {
        this.toDay = toDay;
    }

    public Long getRnum() {
        return rnum;
    }

    public void setRnum(Long rnum) {
        this.rnum = rnum;
    }

    public String getSortCol() {
        return sortCol;
    }

    public void setSortCol(String sortCol) {
        this.sortCol = sortCol;
    }

    public String getSortType() {
        return sortType;
    }

    public void setSortType(String sortType) {
        this.sortType = sortType;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchFromDate() {
        return searchFromDate;
    }

    public void setSearchFromDate(String searchFromDate) {
        this.searchFromDate = searchFromDate;
    }

    public String getSearchToDate() {
        return searchToDate;
    }

    public void setSearchToDate(String searchToDate) {
        this.searchToDate = searchToDate;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getFirstIndex() {
        return firstIndex;
    }

    public void setFirstIndex(int firstIndex) {
        this.firstIndex = firstIndex;
    }

    public int getLastIndex() {
        return lastIndex;
    }

    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }

    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }

    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }

    public boolean isPaging() {
        return isPaging;
    }

    public void setPaging(boolean isPaging) {
        this.isPaging = isPaging;
        this.firstIndex = (this.pageIndex-1)*this.pageSize;
        this.lastIndex = this.pageIndex*this.pageSize;
        this.startPage = ((((this.pageIndex-1)/this.pageUnit)+1)*this.pageUnit)-9;
        this.endPage = (((this.pageIndex-1)/this.pageUnit)+1)*this.pageUnit;
    }

    public String getCrudType() {
        return crudType;
    }

    public void setCrudType(String crudType) {
        this.crudType = crudType;
    }
    
}
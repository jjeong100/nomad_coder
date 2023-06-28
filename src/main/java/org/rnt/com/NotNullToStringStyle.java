package org.rnt.com;

import org.apache.commons.lang.builder.ToStringStyle;

public class NotNullToStringStyle extends ToStringStyle {
	private static final long serialVersionUID = 4279513624854866492L;
	
	public static final ToStringStyle NOT_NULL_STYLE = new NotNullToStringStyle();

    NotNullToStringStyle() {
        super();
        this.setContentStart("[");
        this.setFieldSeparator(", ");
        this.setContentEnd("]");
    }

    private Object readResolve() {
        return NOT_NULL_STYLE;
    }

    @Override
    public void append(StringBuffer buffer, String fieldName, Object value, Boolean fullDetail) {
        if (value != null && !"".equals(value)) {
            appendFieldStart(buffer, fieldName);
            appendInternal(buffer, fieldName, value, isFullDetail(fullDetail));
            appendFieldEnd(buffer, fieldName);
        }
    }
}

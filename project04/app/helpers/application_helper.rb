module ApplicationHelper
    def hidden_div_if(condition, attributes={style: ""}, &block)
        attributes[:style] = "display: none" if condition
        content_tag("div", attributes, &block)
    end
end

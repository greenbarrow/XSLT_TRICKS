<xsl:template name="jsonParserMSE">
    <xsl:param name="code"/>
    <xsl:param name="MSEdata"/>
    
    <xsl:variable name="codes">
        <xsl:analyze-string select="$MSEdata" regex="&quot;code&quot;[ :][ ]*(&quot;.*?&quot;)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:variable name="values">
        <xsl:analyze-string select="$MSEdata" regex="&quot;value&quot;[ :][ ]*(&quot;.*?&quot;)">
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:variable name="valuesList">
        <xsl:for-each select="tokenize(normalize-space($values),'&quot;&quot;')">
            <item>
                <xsl:copy-of select="replace(., '&quot;','')"/>
            </item>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="codesList">
        <xsl:for-each select="tokenize(normalize-space($codes), '&quot;&quot;')">
            <item>
                <xsl:copy-of select="replace(., '&quot;','')"/>
            </item>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:for-each select="$codesList/*:item">
        <xsl:if test=". = $code">
            <xsl:variable name="codePosition" select="position()"/>
            <xsl:value-of select="$valuesList/*:item[position() = $codePosition]/text()"/>
        </xsl:if>
    </xsl:for-each>
    
</xsl:template>
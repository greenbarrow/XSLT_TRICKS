 <!-- default Post Process -->
<xsl:template name="PostProcess">
  <xsl:param name="string"/>
  <xsl:param name="size" select="0"/>
  <xsl:variable name="processedString">
   <xsl:call-template name="string-split">
    <xsl:with-param name="string" select="$string"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:if test="$size = 0">
   <xsl:value-of select="$processedString"/>
  </xsl:if>
  <xsl:if test="$size > 0">
   <xsl:if test="string-length($processedString) >= $size">
    <xsl:value-of select="substring($processedString, 1, $size)"/>
   </xsl:if>
   <xsl:if test="string-length($processedString) &lt; $size">
    <xsl:value-of select="$processedString"/>
   </xsl:if>
  </xsl:if>
 </xsl:template>
 
  <!-- default Post Process  with trim left and capitalize first letter -->
  <xsl:template name="PostProcessCap">
  <xsl:param name="string"/>
  <xsl:param name="size" select="0"/>
  <xsl:variable name="splittedString">
   <xsl:call-template name="string-split">
    <xsl:with-param name="string" select="$string"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="processedString">
   <xsl:call-template name="string-capltrim">
    <xsl:with-param name="string" select="$splittedString"/>
   </xsl:call-template>
  </xsl:variable>
  
  <xsl:if test="$size = 0">
   <xsl:value-of select="$processedString"/>
  </xsl:if>
  <xsl:if test="$size > 0">
   <xsl:if test="string-length($processedString) >= $size">
    <xsl:value-of select="substring($processedString, 1, $size)"/>
   </xsl:if>
   <xsl:if test="string-length($processedString) &lt; $size">
    <xsl:value-of select="$processedString"/>
   </xsl:if>
  </xsl:if>
 </xsl:template>
 
   <!-- default Post Process  with trim left and capitalize first letter -->
  <xsl:template name="PostProcessCapBr">
  <xsl:param name="string"/>
  <xsl:param name="size" select="0"/>
  <xsl:variable name="splittedString">
   <xsl:call-template name="string-split">
    <xsl:with-param name="string" select="$string"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="processedString">
   <xsl:call-template name="string-capltrim_br">
    <xsl:with-param name="string" select="$splittedString"/>
   </xsl:call-template>
  </xsl:variable>
  
  <xsl:if test="$size = 0">
   <xsl:value-of select="$processedString"/>
  </xsl:if>
  <xsl:if test="$size > 0">
   <xsl:if test="string-length($processedString) >= $size">
    <xsl:value-of select="substring($processedString, 1, $size)"/>
   </xsl:if>
   <xsl:if test="string-length($processedString) &lt; $size">
    <xsl:value-of select="$processedString"/>
   </xsl:if>
  </xsl:if>
 </xsl:template>
 
 
 <!-- formatters -->

 <xsl:template name="DateFormat">
  <xsl:param name="dateString"/>
  <xsl:variable name="date"
   select="xs:date(concat(substring($dateString, 1, 4), '-', substring($dateString, 6, 2), '-', substring($dateString, 9, 2)))"/>
  <xsl:value-of select="format-date($date, '[D01].[M01].[Y]')"/>
 </xsl:template>


 <xsl:template name="TimeFormat">
  <xsl:param name="timeString"/>
  <xsl:analyze-string select="$timeString" regex="([0-9]+):([0-9]+):([0-9]+)">
   <xsl:matching-substring>
    <xsl:variable name="hours" select="number(regex-group(1))"/>
    <xsl:variable name="minutes" select="number(regex-group(2))"/>
    <xsl:variable name="seconds" select="number(regex-group(3))"/>
    <xsl:variable name="dateTime"
     select="xs:dateTime(concat('2001-01-01T', format-number($hours, '00'), ':', format-number($minutes, '00'), ':', format-number($seconds, '00'), 'Z'))"/>
    <xsl:value-of select="format-dateTime($dateTime, '[H00]:[m00]:[s00]')"/>
   </xsl:matching-substring>
  </xsl:analyze-string>
 </xsl:template>

 <xsl:template name="PeriodFormat">
  <xsl:param name="pString"/>
  <xsl:analyze-string select="$pString" regex="([0-9]+)Y">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">год</xsl:with-param>
     <xsl:with-param name="str2">года</xsl:with-param>
     <xsl:with-param name="str5">лет</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)M">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">месяц</xsl:with-param>
     <xsl:with-param name="str2">месяца</xsl:with-param>
     <xsl:with-param name="str5">месяцев</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)W">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">неделя</xsl:with-param>
     <xsl:with-param name="str2">недели</xsl:with-param>
     <xsl:with-param name="str5">недель</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)D">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">день</xsl:with-param>
     <xsl:with-param name="str2">дня</xsl:with-param>
     <xsl:with-param name="str5">дней</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 <xsl:template name="PeriodFormatIN">
  <xsl:param name="pString"/>
  <xsl:analyze-string select="$pString" regex="([0-9]+)Y">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">года</xsl:with-param>
     <xsl:with-param name="str2">лет</xsl:with-param>
     <xsl:with-param name="str5">лет</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)M">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">месяца</xsl:with-param>
     <xsl:with-param name="str2">месяцев</xsl:with-param>
     <xsl:with-param name="str5">месяцев</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)W">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">недели</xsl:with-param>
     <xsl:with-param name="str2">недель</xsl:with-param>
     <xsl:with-param name="str5">недель</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
  <xsl:analyze-string select="$pString" regex="([0-9]+)D">
   <xsl:matching-substring>
    <xsl:variable name="v" select="number(regex-group(1))"/>
    <span> </span>
    <xsl:value-of select="$v"/>
    <span> </span>
    <xsl:call-template name="f_plural_form">
     <xsl:with-param name="num" select="$v"/>
     <xsl:with-param name="str1">дня</xsl:with-param>
     <xsl:with-param name="str2">дней</xsl:with-param>
     <xsl:with-param name="str5">дней</xsl:with-param>
    </xsl:call-template>
   </xsl:matching-substring>
  </xsl:analyze-string>
 </xsl:template>


 <xsl:template name="f_plural_form">
  <xsl:param name="num"/>
  <xsl:param name="str1">штука</xsl:param>
  <xsl:param name="str2">штуки</xsl:param>
  <xsl:param name="str5">штук</xsl:param>
  <xsl:variable name="lastN" select="$num mod 10"/>
  <xsl:variable name="lastT" select="$num mod 100"/>
  <xsl:choose>
   <xsl:when test="$lastT >= 10 and 20 >= $lastT">
    <xsl:value-of select="$str5" />
   </xsl:when>
   <xsl:when test="$lastN = 1">
    <xsl:value-of select="$str1" />
   </xsl:when>
   <xsl:when test="$lastN = 2 or $lastN = 3 or $lastN = 4">
    <xsl:value-of select="$str2" />
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$str5" />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 
 <!-- splitters -->
 
 <xsl:variable name="whitespace" select="'&#09;&#10;&#13;  ,.&#160;:;'"/>
 <xsl:variable name="whitespace_br" select="'&#09;&#13;  ,.&#160;:;'"/>

 <xsl:variable name="max_str_size" select="50"/>
 <xsl:variable name="split_str_size" select="30"/>

 <!-- tokenize natural  split -->
 <xsl:template name="string-split">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ' ')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split2">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text> </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

  <!-- insert space instead nbsp -->
 <xsl:template name="string-split2">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ' ')">
   <xsl:choose>

    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split3">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text> </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <!-- '-' is self wrap -->
 <xsl:template name="string-split3">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '-')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split4">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>-</xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

  <!-- insert space after '.' -->
 <xsl:template name="string-split4">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\.')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split5">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>. </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>


  <!-- insert space after ',' -->
 <xsl:template name="string-split5">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ',')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split6">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>, </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

  <!-- insert space after ':' -->
 <xsl:template name="string-split6">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ':')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split7">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>: </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>
 
 <!-- insert space after ';' -->
 <xsl:template name="string-split7">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, ';')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split8">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>; </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

  <!-- insert space after '+' -->
 <xsl:template name="string-split8">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\+')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split9">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>+ </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <!-- insert space after ')' -->
 <xsl:template name="string-split9">
  <xsl:param name="string"/>
  <xsl:for-each select="tokenize($string, '\)')">
   <xsl:choose>
    <xsl:when test="string-length(.) &lt; $max_str_size">
     <xsl:value-of select="."/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-crunch">
      <xsl:with-param name="string" select="."/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="position() != last()">
    <xsl:text>) </xsl:text>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <!-- insert space for break long line -->
 <xsl:template name="string-crunch">
  <xsl:param name="string"/>

  <xsl:variable name="results">
   <xsl:analyze-string select="$string" regex=".">
    <xsl:matching-substring>
     <res>
      <xsl:value-of select="."/>
     </res>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>

  <xsl:for-each select="$results/*">
   <xsl:if test="(position() mod $split_str_size) = 0">
    <xsl:text> </xsl:text>
   </xsl:if>
   <xsl:value-of select="."/>
  </xsl:for-each>
 </xsl:template>


 <!--
 Strips leading whitespace characters from 'string' 
-->
 <xsl:template name="string-ltrim">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace"/>
  <xsl:variable name="unEsc"><xsl:value-of select="$string" /></xsl:variable>
  <xsl:if test="string-length($unEsc) &gt; 0">
   <xsl:choose>
    <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
     <xsl:call-template name="string-ltrim">
      <xsl:with-param name="string" select="substring($unEsc, 2)"/>
      <xsl:with-param name="trim" select="$trim"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="string-split">
      <xsl:with-param name="string" select="$unEsc"/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>


 <!--
 Strips leading whitespace characters from 'string' and capitalize first letter
-->
 <xsl:template name="string-capltrim">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace"/>
  <xsl:variable name="unEsc"><xsl:value-of select="$string" /></xsl:variable>
  <xsl:if test="string-length($unEsc) &gt; 0">
   <xsl:choose>

    <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
     <xsl:call-template name="string-capltrim">
      <xsl:with-param name="string" select="substring($unEsc, 2)"/>
      <xsl:with-param name="trim" select="$trim"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="upper-case(substring($unEsc, 1, 1))"/>
     <xsl:if test="string-length($unEsc) &gt; 1">
      <xsl:call-template name="string-split">
       <xsl:with-param name="string" select="substring($unEsc, 2)"/>

      </xsl:call-template>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>

 <!--
 Strips leading whitespace characters from 'string' process \n as <br/>
-->
 <xsl:template name="string-capltrim_br">
  <xsl:param name="string"/>
  <xsl:param name="trim" select="$whitespace_br"/>
  <xsl:variable name="unEsc"><xsl:value-of select="$string" /></xsl:variable>
  <xsl:variable name="brVar">
   <xsl:if test="string-length($unEsc) &gt; 0">
    <xsl:choose>

     <xsl:when test="contains($trim, substring($unEsc, 1, 1))">
      <xsl:call-template name="string-capltrim_br">
       <xsl:with-param name="string" select="substring($unEsc, 2)"/>
       <xsl:with-param name="trim" select="$trim"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="upper-case(substring($unEsc, 1, 1))"/>
      <xsl:if test="string-length($string) &gt; 1">
       <xsl:call-template name="string-split">
        <xsl:with-param name="string" select="substring($unEsc, 2)"/>

       </xsl:call-template>
      </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:variable>
  <xsl:for-each select="tokenize($brVar, '&#10;')">
   <xsl:value-of select="."/>
   <xsl:if test="position() != last()">
    <xsl:element name="br"/>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <!--  decode to russian -->
 
 <xsl:template name="edizm">
  <xsl:param name="val"/>
  <xsl:choose>
   <xsl:when test="$val = 'Cel'">°С</xsl:when>
   <xsl:when test="$val = 'week'">неделя</xsl:when>
   <xsl:when test="$val = 'hour'">час</xsl:when>
   <xsl:when test="$val = 'month'">месяц</xsl:when>
   <xsl:when test="$val = 'year'">год</xsl:when>
   <xsl:when test="$val = 'day'">день</xsl:when>
   <xsl:when test="$val = 'second'">секунда</xsl:when>
   <xsl:when test="$val = 'minute'">минута</xsl:when>
   <xsl:when test="$val = 'Sv'">Зв</xsl:when>
   <xsl:when test="$val = 'mg/l'">мг/л</xsl:when>
   <xsl:when test="$val = '/yr'">/год</xsl:when>
   <xsl:when test="$val = '10*12/l'">10*12/л</xsl:when>
   <xsl:when test="$val = 'cm2'">см2</xsl:when>
   <xsl:when test="$val = 'mm/h'">мм/ч</xsl:when>
   <xsl:when test="$val = 'Minutes'">минуты</xsl:when>
   <xsl:when test="$val = '/ml'">/мл</xsl:when>
   <xsl:when test="$val = '/mo'">/месяц</xsl:when>
   <xsl:when test="$val = 'mm3'">мм3</xsl:when>
   <xsl:when test="$val = '/d'">/день</xsl:when>
   <xsl:when test="$val = 'mg'">мг</xsl:when>
   <xsl:when test="$val = '10*9/l'">10*9/л</xsl:when>
   <xsl:when test="$val = 'ml'">мл</xsl:when>
   <xsl:when test="$val = 'mm'">мм</xsl:when>
   <xsl:when test="$val = 'mo'">мес</xsl:when>
   <xsl:when test="$val = 'J/min'">Дж/мин</xsl:when>
   <xsl:when test="$val = 'ft3'">фут3</xsl:when>
   <xsl:when test="$val = 'mm[Hg]'">мм.рт.ст.</xsl:when>
   <xsl:when test="$val = 'dioptre'">дптр</xsl:when>
   <xsl:when test="$val = 'nanomol/d'">нмоль/день</xsl:when>
   <xsl:when test="$val = 'in3'">дюйм3</xsl:when>
   <xsl:when test="$val = 'mSv'">мЗв</xsl:when>
   <xsl:when test="$val = 'Hz'">Гц</xsl:when>
   <xsl:when test="$val = 'gm/l'">гм/л</xsl:when>
   <xsl:when test="$val = 'U/l'">Е/л</xsl:when>
   <xsl:when test="$val = 'U/ml'">Е/мл</xsl:when>
   <xsl:when test="$val = '/wk'">/неделю</xsl:when>
   <xsl:when test="$val = 'fl'">фл</xsl:when>
   <xsl:when test="$val = 'IU/ml'">МЕ/мл</xsl:when>
   <xsl:when test="$val = 'm/s'">м/с</xsl:when>
   <xsl:when test="$val = 'µg'">мкг</xsl:when>
   <xsl:when test="$val = 'min'">мин</xsl:when>
   <xsl:when test="$val = 'wk'">недели</xsl:when>
   <xsl:when test="$val = '/min'">уд/мин</xsl:when>
   <xsl:when test="$val = 'U'">Е</xsl:when>
   <xsl:when test="$val = 'millisec'">мс</xsl:when>
   <xsl:when test="$val = 'nanogm/ml'">нг/мл</xsl:when>
   <xsl:when test="$val = 'kg'">кг</xsl:when>
   <xsl:when test="$val = 'dB'">дБ</xsl:when>
   <xsl:when test="$val = 'cc'">см3</xsl:when>
   <xsl:when test="$val = 'a'">лет</xsl:when>
   <xsl:when test="$val = 'd'">дней</xsl:when>
   <xsl:when test="$val = 'm2'">м2</xsl:when>
   <xsl:when test="$val = 'gm'">г</xsl:when>
   <xsl:when test="$val = 'h'">ч.</xsl:when>
   <xsl:when test="$val = 'cm'">см</xsl:when>
   <xsl:when test="$val = 'kg/m2'">кг/м2</xsl:when>
   <xsl:when test="$val = 'm'">м</xsl:when>
   <xsl:when test="$val = 'mmol/l'">ммоль/л</xsl:when>
   <xsl:when test="$val = 'pg/ml'">пг/мл</xsl:when>
   <xsl:when test="$val = 's'">сек</xsl:when>
   <xsl:when test="$val = 'lb'">фунты</xsl:when>
   <xsl:when test="$val = 'pg'">пг</xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$val"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

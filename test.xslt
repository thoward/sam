<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html"/>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="reproduce-markup">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="name()"/>
      <xsl:for-each select="@*">
          <xsl:text> </xsl:text>
          <xsl:value-of select="name()"/>
          <xsl:text>="</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>"</xsl:text>
      </xsl:for-each>
    <xsl:text>&gt;</xsl:text>
      <xsl:apply-templates mode="reproduce-markup"/>
    <xsl:text>&lt;/</xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>&gt;</xsl:text>
  </xsl:template>

    <xsl:template match="tests">
        <html>
            <head>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <a name="top"/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tests/title">
        <h2><xsl:apply-templates/></h2>
        <ul>
            <xsl:for-each select="../test">
                <li>
                    <a href="#{generate-id()}">
                        <xsl:value-of select="title"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="test">
        <a name="{generate-id()}"/>
        <xsl:apply-templates/>
        <a href="#top">^top</a>
    </xsl:template>

    <xsl:template match="test/title">
        <h2 id="{generate-id(..)}">Test: <xsl:apply-templates/></h2>
    </xsl:template>

    <xsl:template match="case">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="case/title">
        <h3>Case: <xsl:apply-templates/></h3>
    </xsl:template>

    <xsl:template match="case/source">
        <h4>Source</h4>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="case/markup">
        <h4>Generated result</h4>
        <pre>
        <xsl:apply-templates mode="reproduce-markup"/>
        </pre>

        <h4>Formatted result (not necessarily supported for all tests)</h4>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="case/result">
        <h4>Intended result</h4>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="codeblock">
        <pre><xsl:apply-templates/></pre>
    </xsl:template>

    <xsl:template match="annotation[@type='bold']">
        <b><xsl:apply-templates/></b>
    </xsl:template>

    <xsl:template match="annotation[@type='code']">
        <tt><xsl:apply-templates/></tt>
    </xsl:template>

    <xsl:template match="annotation[@type='link']">
        <a href="{@specifically}"><xsl:apply-templates/></a>
    </xsl:template>

    <xsl:template match="annotation">
        <span style="color: dark-green">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="citation">
        <xsl:apply-templates/>
        <span style="color: red">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="@value"/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>


    <xsl:template match="grid">
        <table border="1">
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="grid/row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="grid/row/cell">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <xsl:template match="line">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
</xsl:stylesheet>
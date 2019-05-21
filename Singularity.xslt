<?xml version="1.0" encoding="ISO-8859-1"?>

<!-- This XSLT stylesheet allows you to create Avorion ships which have overlapping blocks.

	Usage;
			1) design a ship with root block that will be overlapped with all other blocks in Z-direction.

				e.g. 2x2 crew quarters is the root block (crew quarters are most efficient when large and square)
				Now, behind -or in front- this block, place all other blocks to overlap.

				Repeat until you are done with adding blocks you wish to overlap.

			2) 	Save the ship, by exiting build mode.

			3)  Navigate to the saved vessel; it is located in %appdata%/avorion/ships ( in linux: ~/.avorion/ships )

			4) Apply this XSLT to the ship's XML file.

			5) Save the modifed XML under a different name.

			6) leave galaxy, and re-join to ensure visiblity of new ship xml

			7) Enter build mode of the ship, apply the newly created ship plan

	End result:

	All blocks will start where the root block starts; in z-direction.
	All block proportions will be kept intact.

	Note:
	If blocks were to the side (x or y) of other blocks; they will have moved in z-direction.
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Output root element unaltered -->
<xsl:template match="/*">
<xsl:variable name="name">
	 <xsl:value-of select="name()"/>
</xsl:variable>
 <xsl:element name="{$name}">
 <xsl:element name="plan">
	 <xsl:attribute name="accumulateHealth" >
		<xsl:value-of select="'true'"/>
	 </xsl:attribute>
	 <xsl:attribute name="convex" >
		<xsl:value-of select="'false'"/>
	 </xsl:attribute>
<xsl:apply-templates select="node()"/>
 </xsl:element>
   </xsl:element>
</xsl:template>

<!-- center all blocks -->
<xsl:template match="item">
	<item>
		<!--Populate the attributes for the item element with same values.-->
		 <xsl:copy-of select="@*" />
		<block>
			<!--Copy all values, except the ones for z, we will modify those.-->
			 <xsl:copy-of select="block/@*[name()!='lz' and name()!='uz' and name()!='lx' and name()!='ux' and name()!='ly' and name()!='uy']" />

			<!-- For every axis : calculate the average, then find its offset to zero, then apply that offset-->
			<xsl:variable name="offsetX">
			   <xsl:value-of select="-(number(block/@ux)+number(block/@lx)) div 2"/>
			</xsl:variable>

			<xsl:variable name="offsetY">
			   <xsl:value-of select="-(number(block/@uy)+number(block/@ly)) div 2"/>
			</xsl:variable>

			<xsl:variable name="offsetZ">
			   <xsl:value-of select="-(number(block/@uz)+number(block/@lz)) div 2"/>
			</xsl:variable>

			<xsl:attribute name="lx">
			   <xsl:value-of select="$offsetX + block/@lx"/>
			</xsl:attribute>

			<xsl:attribute name="ux">
			   <xsl:value-of select="$offsetX + block/@ux"/>
			</xsl:attribute>

			<xsl:attribute name="ly">
			   <xsl:value-of select="$offsetY + block/@ly"/>
			</xsl:attribute>

			<xsl:attribute name="uy">
			   <xsl:value-of select="$offsetY + block/@uy"/>
			</xsl:attribute>

			<xsl:attribute name="lz">
			   <xsl:value-of select="$offsetZ + block/@lz"/>
			</xsl:attribute>

			<xsl:attribute name="uz">
			   <xsl:value-of select="$offsetZ + block/@uz"/>
			</xsl:attribute>

		</block>
	</item>
</xsl:template>


</xsl:stylesheet>
<?xml version="1.0" encoding="utf-8" ?>
<Configuration>
    <SelectionSets><SelectionSet>
        <Name>FileSystemTypes</Name>
        <Types>
            <TypeName>System.IO.DirectoryInfo</TypeName>
            <TypeName>System.IO.FileInfo</TypeName>
        </Types>
    </SelectionSet></SelectionSets>

    <!-- ################ GLOBAL CONTROL DEFINITIONS ################ -->
    <Controls><Control>
        <Name>FileSystemTypes-GroupingFormat</Name>
        <CustomControl><CustomEntries><CustomEntry><CustomItem><Frame><CustomItem>
            <Text AssemblyName="System.Management.Automation" BaseName="FileSystemProviderStrings" ResourceId="DirectoryDisplayGrouping"/>
            <ExpressionBinding>
                <ScriptBlock>
                    $_.PSParentPath.Replace("Microsoft.PowerShell.Core\FileSystem::", "")
                </ScriptBlock>
            </ExpressionBinding>
        </CustomItem></Frame></CustomItem></CustomEntry></CustomEntries></CustomControl>
    </Control></Controls>

    <!-- ################ VIEW DEFINITIONS ################ -->
    <ViewDefinitions>
        <View>
        <Name>children</Name>
        <ViewSelectedBy><SelectionSetName>FileSystemTypes</SelectionSetName></ViewSelectedBy>
        <GroupBy>
            <PropertyName>PSParentPath</PropertyName>
            <CustomControlName>FileSystemTypes-GroupingFormat</CustomControlName>
        </GroupBy>
        <TableControl>
            <TableHeaders>
                <TableColumnHeader><Label>Mode</Label><Width>7</Width><Alignment>left</Alignment></TableColumnHeader>
                <TableColumnHeader><Label>LastWriteTime</Label><Width>16</Width><Alignment>right</Alignment></TableColumnHeader>
                <TableColumnHeader><Label>Length</Label><Width>7</Width><Alignment>right</Alignment></TableColumnHeader>
                <TableColumnHeader/>
            </TableHeaders>
            <TableRowEntries><TableRowEntry>
                <Wrap/>
                <TableColumnItems>
                    <TableColumnItem><PropertyName>Mode</PropertyName></TableColumnItem>
                    <TableColumnItem><ScriptBlock>
                        [String]::Format("{0,10} {1,5}", $_.LastWriteTime.ToString("d"), $_.LastWriteTime.ToString("HH:mm"))
                    </ScriptBlock></TableColumnItem>
                    <TableColumnItem><ScriptBlock>
                            if     ($_ -is [System.IO.DirectoryInfo]) {""}
                            elseif ($_.length -gt 2TB) {($_.length / 1TB).ToString('#,##0" T"') }
                            elseif ($_.length -gt 2GB) {($_.length / 1GB).ToString('#,##0" G"') }
                            elseif ($_.length -gt 2MB) {($_.length / 1MB).ToString('#,##0" M"') }
                            elseif ($_.length -gt 2KB) {($_.length / 1KB).ToString('#,##0" K"') }
                            else   {$_.length.ToString('#,##0" bytes"')}
                    </ScriptBlock></TableColumnItem>
                    <TableColumnItem><PropertyName>Name</PropertyName></TableColumnItem>
                </TableColumnItems>
            </TableRowEntry></TableRowEntries>
        </TableControl>
        </View>
    </ViewDefinitions>
</Configuration>
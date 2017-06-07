#Set-ExecutionPolicy Unrestricted

Clear-Host;

# Configuration settings. 
#[String] $SqlInstance = "ec2-52-38-229-171.us-west-2.compute.amazonaws.com,5433";
 [String] $SqlInstance = "STIXRUD-P70\SQL2016";
 [String] $Database    = "CETMGMT";
#[String] $Database    = "CETMGMT_Claim";
#[String] $Database    = "CETMGMT_Claim_Staging";
#[String] $Database    = "CETMGMT_Module";
#[String] $Database    = "CETMGMT_Module_Staging";
#[String] $Database    = "CETMGMT_Staging";

#Write-Host 'Enter SQL credentials for deployment:'
#$Username = Read-Host 'Username?';
#$Response = Read-Host 'Password?' -AsSecureString;
#$Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Response));

$SqlConnection = New-Object System.Data.SQLClient.SQLConnection;

#$SqlConnection.ConnectionString = "Server=$SqlInstance; Database=$Database; User Id=$Username; Password=$Password;";
$SqlConnection.ConnectionString = "Server=$SqlInstance; Database=master; Integrated Security=True;";

# Full path of the directory for this .ps1 script
$BasePath = (Get-Item (Split-Path $MyInvocation.MyCommand.Path)).FullName;

# Register event "InfoMessage" and define action for it.
$Nil = Register-ObjectEvent $SqlConnection -EventName InfoMessage -Action {

    $SqlInfo = $Event.SourceEventArgs; 
    Write-Host $SqlInfo.Message;     
}

Function ExecuteSql([string]$InputFile) {

    $StreamReader = New-Object System.IO.StreamReader("$BasePath\$InputFile");
    $SqlCode = $StreamReader.ReadToEnd() -split "GO\r\n|GO\s*\r\n";
    $StreamReader.Close();
    $StreamReader.Dispose();

    foreach($Batch in $SqlCode) {

        if ($Batch.Trim() -ne "") {

            $SQLCommand = New-Object System.Data.SQLClient.SQLCommand;
            $SQLCommand = $SQLConnection.CreateCommand();
            $SQLCommand.commandtimeout = 0;
            $SQLCommand.CommandText = $Batch.Replace("<database_name>", $Database);
            
            Try {

                $Nil = $SQLCommand.Executenonquery() | Out-Null;
            }
            Catch {

                Throw $_;
            }
        }
    }
}

Try {

    $SqlConnection.Open(); 

    Write-Verbose "Connected to server $SqlInstance";

    ExecuteSql -InputFile "Database\CreateDatabase.sql";
    ExecuteSql -InputFile "Functions\config.GetCedarsApiToken.sql";
	ExecuteSql -InputFile "Functions\config.GetCedarsDatabase.sql";
    ExecuteSql -InputFile "Functions\config.GetCedarsDirectory.sql";
    ExecuteSql -InputFile "Functions\config.GetCedarsUriString.sql";
    ExecuteSql -InputFile "Procedures\dbo.PrintOutput.sql";
    ExecuteSql -InputFile "Procedures\dbo.CreateSynonym.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_CETJobs.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_InputMeasureCEDARS.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_InputProgramCEDARS.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_Program.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_ProgramCost.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_RunCET.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedCE.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedCost.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedEmissions.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedInputCEDARS.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedProgramCostCEDARS.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedSavings.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CET_SavedValidation.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_Claim.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_ContactClaim.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CostEffectiveness.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_CustomMeasure.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_DeemedMeasure.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_ProgramCost.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_Site.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CEDARS_WaterMeasure.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CETMGMT_InputMeasureView.sql";
    ExecuteSql -InputFile "Synonyms\dbo.CETMGMT_InputProgramView.sql";
    ExecuteSql -InputFile "SQLSharp\bin\Release\SQLSharpInstall.sql";
    ExecuteSql -InputFile "ServiceBroker\ServiceBrokerInstall.sql";
    ExecuteSql -InputFile "ServiceBroker\ServiceBrokerSecurity.sql";
    ExecuteSql -InputFile "Functions\dbo.GetErrorString.sql";
    ExecuteSql -InputFile "Functions\dbo.GetJsonString.sql";
    ExecuteSql -InputFile "Functions\dbo.ParseDirectory.sql";
    ExecuteSql -InputFile "Functions\dbo.ParseFileName.sql";
    ExecuteSql -InputFile "Functions\dbo.SavedData_Inputs.sql";
    ExecuteSql -InputFile "Functions\dbo.SavedData_Outputs.sql";
    ExecuteSql -InputFile "Functions\dbo.SavedData_ProgramCost.sql";
    ExecuteSql -InputFile "Functions\dbo.SavedData_Validation.sql";
    ExecuteSql -InputFile "Tables\Staging.Claim.sql";
    ExecuteSql -InputFile "Tables\Staging.ContactClaim.sql";
    ExecuteSql -InputFile "Tables\Staging.CustomMeasure.sql";
    ExecuteSql -InputFile "Tables\Staging.DeemedMeasure.sql";
    ExecuteSql -InputFile "Tables\Staging.Measure.sql";
    ExecuteSql -InputFile "Tables\Staging.Program.sql";
    ExecuteSql -InputFile "Tables\Staging.ProgramCost.sql";
    ExecuteSql -InputFile "Tables\Staging.Site.sql";
    ExecuteSql -InputFile "Tables\Staging.WaterMeasure.sql";
    ExecuteSql -InputFile "Tables\dbo.JobActivity.sql";
    ExecuteSql -InputFile "Views\dbo.Claim_CET_MeasureView.sql";
    ExecuteSql -InputFile "Views\dbo.Claim_CET_ProgramCostView.sql";
    ExecuteSql -InputFile "Views\dbo.JobActivityView.sql";
    ExecuteSql -InputFile "Procedures\dbo.AlterQueue.sql";
    ExecuteSql -InputFile "Procedures\dbo.ArchiveFile.sql";  
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsClaim.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsContactClaim.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsCostEffectiveness.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsCustomMeasure.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsDeemedMeasure.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsProgramCost.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsSite.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCedarsWaterMeasure.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCETInputMeasure.sql";
    ExecuteSql -InputFile "Procedures\dbo.InsertCETInputProgram.sql";  
    ExecuteSql -InputFile "Procedures\dbo.JobExecute.sql";
    ExecuteSql -InputFile "Procedures\dbo.JobActivation.sql";
    ExecuteSql -InputFile "Procedures\dbo.JobInvoke.sql";
    ExecuteSql -InputFile "Procedures\dbo.SendWebRequest.sql";
    ExecuteSql -InputFile "Procedures\dbo.ScrubStagging.sql";
      
    #ExecuteSql -InputFile "Procedures\dbo.IngestDataFile.sql";
    #ExecuteSql -InputFile "Procedures\dbo.ImportFiles.sql";
}
Catch {

    Throw $_
}
Finally {

    $SqlConnection.Close();
}

/****** Script for SelectTopNRows command from SSMS  ******/
select L.*, 
	[dbo].[GetBestMeaningForLemma](L.Root, L.Lemma) as Meaning, 
	(SELECT TOP 1 Ayah + CHAR(13) + Translation FROM [dbo].[GetVersesFromLemma](L.Root, L.Lemma)) as Verse
	INTO LemmaMeaningWithAyah
FROM
(
SELECT TOP 100 percent
		[Root],
      [Lemma]     
	  ,count(1) as Occurences	  
  FROM [Quran].[dbo].[WordInformation]   
  where [Root] != '' and [Lemma] != ''  
  group by [root], Lemma
  having count(1) > 2
  order by Occurences DESC
) L
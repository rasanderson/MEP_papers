# Using the google scholar package
#library(tidyverse,lib='c:/Giles/R/Libraries')
#library(scholar,lib='c:/Giles/R/Libraries')
library(tidyverse)
library(scholar)
library(kableExtra)

# Roy's Google Scholar id
# from https://scholar.google.co.uk/citations?user=z6jaMRcAAAAJ&hl=en

# Should now read without NA problems
mep_data <- read_csv("google_scholar_MEP.csv")


scholar_ids<- mep_data$Scholar_ID

all_pubs<-NULL

for(ss in scholar_ids) {
  get_publications(ss) %>%
    rbind(all_pubs)  -> all_pubs   
}

all_pubs %>% 
  
  mutate(All_info=paste(year,title,author,journal,number,sep = ", "),
         Title_lower=tolower(title)) %>% 
  arrange(desc(All_info)) %>% 
  distinct(cid, .keep_all = TRUE) %>% 
  distinct(Title_lower, .keep_all = TRUE) %>% 
  filter(year!="1977") %>% #odd one for Roy  
  dplyr::select(All_info)->all_pubs_trim  

# Was there a specific reason for going for tsv rather than csv?
write_tsv(all_pubs_trim,"MEP_publications.tsv")
write_csv(all_pubs_trim,"MEP_publications.csv")
#write_csv((paste("C:/Giles/Group stuff/Website/Publications - Dist", ,".csv")))

# As HTML
# Create table in suitable format
pubs_for_kbl <- all_pubs %>% 
  arrange(desc(year)) %>% 
  distinct(cid, .keep_all = TRUE) %>% 
  filter(is.na(year) == FALSE) %>% 
  mutate(publication = paste(journal, number),
         title_lower = tolower(title)) %>% 
  distinct(title_lower, .keep_all = TRUE) %>% 
  select(year, author, title, publication)

# Output as HTML
kbl(pubs_for_kbl) %>% 
  kable_paper() %>% 
  scroll_box(width = "100%", height = "100%") %>% 
  kable_styling(fixed_thead = TRUE) %>% 
  save_kable("MEP_publications.html", self_contained = TRUE)
  




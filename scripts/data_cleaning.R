#Load the Tidyverse library.
library(tidyverse)

# Import the csv file as a dataframe and call it platform_gender.
# skip the first three lines (which have instructions)
# Rename headers since R can't handle long headers with spaces 

platform_gender <-                       # platform_gender is the name we're giving this data
  read_csv2(                             # read_csv2() imports a csv file that has ; separators
    "data/platformgender.csv",
    skip = 3,                            # Skip the first 3 rows
    col_select = c(                      # Select these columns and rename them
      "site" = "Site Name",
      "URL" = "URL",
      "require_gender" = "Gender required?",
      "edit_gender" = "Can you choose/change your gender on the site later on?",
      "gender_options" = "Gender options available",
      "country" = "Country it is based in",
      "site_type" = "Type of site",
      "comments" = "Comments (notes that you couldn't fit in the quantitative columns)"
    )
  )

platform_gender <- platform_gender %>% 
  mutate(require_gender = recode(require_gender,
                                 "no" = "No"),
         site_type = recode(site_type,
                            "Social media" = "Social Media"),
         country = recode(country,
                          "American" = "USA"),
         region = recode(country,                     # New field grouping countries
                          "Norway" = "Scandinavia",
                          "Denmark" = "Scandinavia",
                          "Sweden" = "Scandinavia",
                          "British" = "Rest of Europe",
                          "Germany" = "Rest of Europe",
                          "France" = "Rest of Europe",
                          "Luxembourg" = "Rest of Europe",
                          "China" = "Asia",
                          "Japan" = "Asia")) %>%
  

write_csv2(platform_gender, "data/platformgender2.csv")

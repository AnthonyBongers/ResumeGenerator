{-# LANGUAGE OverloadedStrings #-}

import Data.List (intersperse)
import Data.Monoid (mconcat, (<>))
import Control.Monad (forM_)
import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A

skillsets = 
  [ ( "Programming", [ "C++", "C#", "Objective-C", "Java", "Haskell", "Bash" ] )
  , ( "Software",    [ "Jira", "Github", "Xcode", "Vim", "Zsh", "Tmux", "Git", "Charles" ] )
  , ( "Other",       [ "Scrum", "Agile", "Software Design", "Code Review", "Debugging" ] )
  ]
  
jobs = 
  [ ( "You.i TV", "Technical Lead", "Aug 2016 - Present", 
        [ "doing stuff" 
        ] )
        
  , ( "SmokeLabs Inc.", "Senior Software Developer", "May 2012 - Aug 2016", 
        [ "Designing and implementing dynamic software systems"
        , "Performing code reviews using Atlassian Crucible"
        , "Researching tools and libraries for new projects"
        , "Using Atlassian Jira to create and complete tasks efficiently"
        , "Created a socket-based authoritative server for a multiplayer cross-platform title"
        , "Created a multithreaded REST client to integrate an API into an application"
        , "Developed an educational mathematics game for aboriginal children in Saskatchewan"
        , "Designed and implemented a dynamic resource resolution downloader to decrease program size"
        , "Integrated multiple 3rd party APIs into many titles"
        ] )
        
  , ( "Arctic Empire", "Software Developer", "Dec 2011 - Mar 2012", 
        [ "Ported an existing Objective-C iOS app to Java to run on Android"
        , "Worked alongside off-site developers on a new iOS application"
        , "Developed a rapid prototype alongside developers and artists at a global development event"
        ] )
        
  , ( "Magmic Inc.", "Software Developer", "May 2010 - Dec 2011", 
        [ "Ported games to various phones with strict memory and computational power restrictions"
        , "Updated a legacy Java game to C++/Objective-C and OpenGL to run on iOS devices"
        , "Debugged and fixed logic issues in existing titles"
        , "Addressed user feedback to improve applications"
        , "Participated in an agile group and participated in daily scrums"
        , "Worked alongside Quality Assurance to resolve issues efficiently"
        ] )
  ]
  
education = 
  [ ( "Course", "Game Development at Algonquin College (2008 - 2011)" )
  , ( "Diploma", "Ontario Advanced Diploma" )
  , ( "Awards", "Dean's Honour List" )
  ]

renderContactDetails = 
  table ! tableStyle $ do
    tr $ do
      td $ do
        h1 ! nameStyle $ "Anthony Bongers"
      td $ do
        p ! infoStyle $ "bongers.anthony@gmail.com"
        p ! infoStyle $ "(613) 123 - 4567"
        p ! infoStyle $ "https://github.com/AnthonyBongers"
        
  where 
    tableStyle = A.style $ mconcat 
      [ "width: 100%;"
      , "border-spacing: 0;"
      ]
    nameStyle = A.style $ mconcat
      [ "color: #367DA2;"
      , "font-family: 'Born';"
      , "font-size: 30pt;"
      , "font-weight: normal;"
      ]
    infoStyle = A.style $ mconcat
      [ "margin-bottom: 0;"
      , "margin-top: 0;"
      , "text-align: right;"
      , "font-family: 'Born';"
      , "font-size: 12pt;"
      ]
      
renderTitle = h2 ! sectionStyle
  where 
    sectionStyle = A.style $ mconcat
      [ "color: #175778;"
      , "margin-top: 0.5em;"
      , "margin-bottom: 0.25em;"
      , "font-family: 'Charter';"
      , "font-size: 18pt" 
      ]

renderSkills = do
  renderTitle "Skills"
  table ! tableStyle $ do
    forM_ skillsets $ \(title, skills) -> do
      tr $ do
        td $ p ! titleStyle $ title <> " :"
        td $ p ! infoStyle $ mconcat . intersperse "      " $ skills
          
  where 
    infoStyle = A.style $ mconcat
      [ "margin-bottom: 0.2em;"
      , "margin-top: 0;"
      , "white-space:pre;"
      , "font-family: 'Born';" 
      , "font-size: 12pt;"
      ]
    titleStyle = A.style $ mconcat 
      [ "margin-bottom: 0.2em;" 
      , "margin-top: 0;"
      , "white-space:pre;"
      , "font-family: 'Born';"
      , "font-size: 12pt;"
      , "font-weight: bold;"
      ]
    tableStyle = A.style $ mconcat
      [ "width: 100%;"
      ]
  
renderJobs = do
  renderTitle "Work Experience"
  forM_ jobs $ \(company, title, time, tasks) -> do 
    h4 ! headerStyle $ company <> " - " <> title <> " (" <> time <> ")"
    ul ! listStyle $ forM_ tasks $ \task ->
      li ! taskStyle $ "- " <> task
  
  where
    headerStyle = A.style $ mconcat 
      [ "margin: 0;"
      , "font-family: 'Charter';"
      , "font-size: 12pt;" 
      ]
    listStyle = A.style $ mconcat 
      [ "margin-top: 0;"
      , "padding: 0;"
      , "list-style-type: none;" 
      ]
    taskStyle = A.style $ mconcat 
      [ "font-family: 'Born';"
      , "font-size: 12pt;" 
      ]
      
renderEducation = do
  renderTitle "Education"
  table ! tableStyle $ do
    forM_ education $ \(key, value) -> do
      tr $ do
        td $ p ! titleStyle $ key <> " :"
        td $ p ! infoStyle $ value
          
  where 
    infoStyle = A.style $ mconcat
      [ "margin-bottom: 0.2em;"
      , "margin-top: 0;"
      , "white-space:pre;"
      , "font-family: 'Born';" 
      , "font-size: 12pt;"
      ]
    titleStyle = A.style $ mconcat 
      [ "margin-bottom: 0.2em;" 
      , "margin-top: 0;"
      , "white-space:pre;"
      , "font-family: 'Born';"
      , "font-size: 12pt;"
      , "font-weight: bold;"
      ]
    tableStyle = A.style $ mconcat
      [ "width: 100%;"
      ]

  
renderResume :: Html
renderResume = docTypeHtml $ do
  H.head $ do
    H.title "Resume"
  body ! pageStyle $ do
    renderContactDetails
    renderSkills
    renderJobs
    renderEducation
    
  where 
    pageStyle = A.style $ mconcat
      [ "height: 842px;"
      , "width: 680px;"
      , "margin-left: auto;"
      , "margin-right: auto;"
      ]
        

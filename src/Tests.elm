module Tests where

import Json.Decode
import ElmTest exposing (Test, test, suite, assertEqual)

import MeetupGroup

-- Note: You need to double escape \ in the literal below, Elm parsing bug?
exampleGetGroupJson : String
exampleGetGroupJson = """
{"id":19111172,"name":"Elm User Group Dublin","link":"http://www.meetup.com/Elm-User-Group-Dublin/","urlname":"Elm-User-Group-Dublin","description":"<p>A group dedicated to Elm programming. Come along to learn about Elm, chat and hack on Elm projects. We'll be running social meetups, talks and maybe hack days.</p>\\n<p>We're an inclusive group, we want folks of all technical levels who are interested in learning or using Elm. If Elm is your first programming language, good for you, you've made a good choice! If you've been programming for years and you're dipping your toes into this \\"functional lark\\" then you're really going to like Elm.</p>\\n<p>We adhere to the conference code of conduct:&nbsp;<a href=\\"http://confcodeofconduct.com\\" class=\\"linkified\\">http://confcodeofconduct.com</a></p>","created":1447238990000,"city":"Dublin","country":"IE","state":"","join_mode":"open","visibility":"public","lat":53.33000183105469,"lon":-6.25,"members":73,"organizer":{"id":1541118,"name":"Michael Twomey","bio":"Dublin based software engineer. Helps with Coding Grace events.","photo":{"id":246788351,"highres_link":"http://photos1.meetupstatic.com/photos/member/2/0/9/f/highres_246788351.jpeg","photo_link":"http://photos3.meetupstatic.com/photos/member/2/0/9/f/member_246788351.jpeg","thumb_link":"http://photos1.meetupstatic.com/photos/member/2/0/9/f/thumb_246788351.jpeg"}},"who":"Members","group_photo":{"id":444751251,"highres_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/highres_444751251.jpeg","photo_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/600_444751251.jpeg","thumb_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/thumb_444751251.jpeg"},"timezone":"Europe/Dublin","category":{"id":34,"name":"Tech","shortname":"Tech","sort_name":"Tech"},"photos":[{"id":444751251,"highres_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/highres_444751251.jpeg","photo_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/600_444751251.jpeg","thumb_link":"http://photos1.meetupstatic.com/photos/event/7/a/1/3/thumb_444751251.jpeg"},{"id":446104945,"highres_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/highres_446104945.jpeg","photo_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/600_446104945.jpeg","thumb_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/thumb_446104945.jpeg"}],"last_event":{"id":"227979749","name":"Elm Meetup and Hackathon","yes_rsvp_count":15,"time":1453316400000,"utc_offset":0},"event_sample":[{"id":"227979749","name":"Elm Meetup and Hackathon","yes_rsvp_count":15,"time":1453316400000,"utc_offset":0,"photo_album":{"id":26684244,"title":"","photo_count":1,"photo_sample":[{"id":446104945,"highres_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/highres_446104945.jpeg","photo_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/600_446104945.jpeg","thumb_link":"http://photos3.meetupstatic.com/photos/event/1/3/5/1/thumb_446104945.jpeg"}]}}]}
"""

testDeserializeGetGroupJson : Test
testDeserializeGetGroupJson =
  test "decode get group"
    ( assertEqual
      ( Ok
        { id = 19111172
        , members = 73
        , link = "http://www.meetup.com/Elm-User-Group-Dublin/"
        }
      )
      ( Json.Decode.decodeString MeetupGroup.decodeGetGroupJson exampleGetGroupJson )
    )

jsonTests : Test
jsonTests =
  suite "JSON tests"
    [ testDeserializeGetGroupJson
    ]

tests : Test
tests =
  suite "Elm Dublin Tests"
    [ jsonTests
    ]

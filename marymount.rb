module Marymount

  A = Hash.new
  B = Hash.new

  A['Mon'] = <<END

A Week :: Monday
8:20-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Free
10:00-10:45 -- Independent Study: Latin
10:45-11:30 -- Free
11:30-12:30 -- Lunch
12:30-1:15  -- Free
1:15-2:00   -- Latin I
2:00-2:45   -- Free
2:45-3:30   -- Intro to Programming
3:30-?      -- US meeting

END

  A['Tue'] = <<END

A Week :: Tuesday
8:20-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Free
10:00-10:45 -- Free
10:45-11:30 -- Latin I
11:30-12:30 -- Lunch
12:30-1:15  -- Intro to Programming
1:15-2:00   -- Free
2:00-2:45   -- Computer Science, Section 2
2:45-3:30   -- Computer Science, Section 4

END

  A['Wed'] = <<END

A Week :: Wednesday
8:20-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Free
10:00-10:45 -- Computer Science, Section 3
10:45-11:30 -- Computer Science, Section 1
11:30-12:30 -- Philosophy Club
12:30-1:15  -- Free
1:15-1:45   -- Advisory Group
1:45-2:45   -- Assembly

END

  A['Thu'] = <<END

A Week :: Thursday
8:20-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Computer Science, Section 1
10:00-10:45 -- Latin I
10:45-11:30 -- Latin I
11:30-12:30 -- Lunch; Chapel
12:30-1:15  -- Free
1:15-2:00   -- Free
2:00-2:45   -- Intro to Programming
2:45-3:30   -- Free

END

  A['Fri'] = <<END

A Week :: Friday
8:15-8:30   -- Advisor
8:30-9:15   -- Intro to Programming
9:15-10:00  -- Free
10:00-10:45 -- Computer Science, Section 3
10:45-11:30 -- Free
11:30-12:15 -- Computer Science, Section 2
12:15-12:45 -- Lunch
12:45-1:30  -- Free
1:30-2:15   -- Computer Science, Section 4
2:15-3:00   -- Free

END

  B['Mon'] = <<END

B Week :: Monday
8:20-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Free
10:00-10:45 -- Free
10:45-11:30 -- Free
11:30-12:30 -- Lunch
12:30-1:15  -- Free
1:15-2:00   -- Intro to Programming
2:00-2:45   -- Latin I
2:45-3:30   -- Free
3:30-?      -- US meeting

END

  B['Tue'] = <<END

B Week :: Tuesday
8:20-8:30   -- Advisor
8:30-9:15   -- Latin I
9:15-10:00  -- Latin I
10:00-10:45 -- Free
10:45-11:30 -- Intro to Programming
11:30-12:30 -- Lunch
12:30-1:15  -- Free
1:15-2:00   -- Free
2:00-2:45   -- Free
2:45-3:30   -- Free

END

  B['Wed'] = <<END

B Week :: Wednesday
8:20-8:30   -- Advisor
8:30-9:15   -- Computer Science, Section 3
9:15-10:00  -- Computer Science, Section 1
10:00-10:45 -- Computer Science, Section 4
10:45-11:30 -- Computer Science, Section 2
11:30-12:30 -- Philosophy Club
12:30-1:15  -- Free
1:15-1:45   -- Advisory Group
1:45-2:45   -- Assembly

END

  B['Thu'] = <<END

B Week :: Thursday
8:20-8:30   -- Advisor
8:30-9:15   -- Independent Study: Latin
9:15-10:00  -- Free
10:00-10:45 -- Intro to Programming
10:45-11:30 -- Free
11:30-12:30 -- Lunch; Chapel
12:30-1:15  -- Free
1:15-2:00   -- Free
2:00-2:45   -- Latin I
2:45-3:30   -- Computer Science, Section 3

END

  B['Fri'] = <<END

B Week :: Friday
8:15-8:30   -- Advisor
8:30-9:15   -- Free
9:15-10:00  -- Latin I
10:00-10:45 -- Computer Science, Section 4
10:45-11:30 -- Computer Science, Section 2
11:30-12:15 -- Computer Science, Section 1
12:15-12:45 -- Lunch
12:45-1:30  -- Free
1:30-2:15   -- Free
2:15-3:00   -- Free

END

end

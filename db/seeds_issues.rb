# Populate issues with content from reference site
issues_data = [
  {
    title: "Tax Relief & Fairness",
    icon: "money",
    position: 1,
    featured: true,
    tagline: "We don't just promise tax cuts—we deliver real relief, invest in families and business, and let you see and shape where your dollars go. That's the Carolina Way.",
    description: <<~HTML,
      <ul>
        <li><strong>Family Tax Dividend:</strong> Each year the state budget runs a surplus, every household receives a "Tax Dividend"—an annual local tax credit distributed at back-to-school time for help with school supplies, childcare, or family needs.</li>
        <li><strong>Small Business "Start Here, Grow Here" Tax Holiday:</strong> New local businesses and small farms under $1 million revenue pay zero state income tax and business license fees for their first two years. Paired with a mentorship network, this supports entrepreneurship from within the district.</li>
        <li><strong>Keep What You Build:</strong> Pilot program so towns and counties keep a bigger share of sales, hospitality, or business tax revenue generated above last year's baseline, funding local roads, schools, or emergency services, with a transparent dashboard for residents.</li>
        <li><strong>Automatic Taxpayer Refunds for Budget Overruns:</strong> Any state-funded project that comes in under budget has its savings automatically refunded to taxpayers, not rolled into agency surpluses.</li>
        <li><strong>Zero-Tax "Workforce Comeback" Scholarship Fund:</strong> Scholarships for adult learners, veterans, and returning citizens—funded by closing outdated tax loopholes, with tax forgiveness for participants who complete training and work locally.</li>
        <li><strong>Digital Taxpayer Bill of Rights:</strong> A mobile app and website for residents to view their tax footprint, claim credits, report tax waste, and submit ideas for savings—open to public voting each year.</li>
        <li><strong>Audit the System, Not the People:</strong> A citizens' tax review board of local residents reviews all new tax proposals before any vote, ensuring accountability and transparency.</li>
      </ul>
    HTML
    summary: "Family Relief: Annual tax dividend for local families\nSmall Business: 2-year tax holiday for new local entrepreneurs\nLocal Control: Communities keep more of their tax growth\nFiscal Accountability: Refunds for under-budget state projects\nWorkforce Investment: Tax-free scholarships & job retraining\nTransparency: Digital Taxpayer Bill of Rights & public dashboard\nCitizen Oversight: Local review board for new taxes"
  },
  {
    title: "Jobs & Wages",
    icon: "briefcase",
    position: 2,
    featured: true,
    tagline: "We build good jobs here, keep families together, and power Carolina's future with homegrown talent—not empty promises.",
    description: <<~HTML,
      <ul>
        <li><strong>Union Power & Fair Wages Guarantee:</strong> Expand the right to organize, launch "Union Fast-Track" grants for small businesses that pay fair wages and benefits, and fight for a $15+ minimum wage indexed to inflation.</li>
        <li><strong>Carolina Skills Accelerator:</strong> Create a Skills Accelerator Network with technical colleges, unions, and employers for tuition-free training in trades, IT, green energy, and advanced manufacturing. Paid apprenticeships for youth, veterans, and career-changers. Guaranteed job offer or placement support for every graduate.</li>
        <li><strong>Small Business Boost & Buy Local First:</strong> Launch a Start-Here Fund for zero-interest microloans and a two-year tax holiday for new local businesses and family farms. Prioritize local businesses for public purchasing. Start a Business Startup Concierge to help entrepreneurs with permits, financing, and mentorship.</li>
        <li><strong>Rural Job Engines & Broadband for All:</strong> Establish Rural Job Hubs and advanced training centers in small towns. Expand high-speed broadband and cell coverage to unlock remote work and digital entrepreneurship across the district.</li>
        <li><strong>Next-Generation Infrastructure & Green Jobs:</strong> Build and repair roads, bridges, and water systems with local union labor and apprentices. Invest in clean energy jobs—solar, wind, and batteries—with worker ownership incentives and retraining for fossil fuel workers. Launch a Carolina Conservation Corps for youth and veterans to restore parks, fight flooding, and boost tourism.</li>
        <li><strong>Veterans & Second Chance Employment:</strong> Partner with unions and employers for a Veteran Skills Bridge program—guaranteed training and job placement for returning servicemembers. Offer Second Chance Hiring Incentives (tax credits and support) for businesses hiring formerly incarcerated people and those recovering from addiction, with mentorship and counseling.</li>
        <li><strong>Family Support & Commuter Relief:</strong> Double investments in affordable childcare, afterschool, and elder care so more parents can work or train. Support flexible scheduling and commuter assistance, including transit options and gas vouchers for shift workers.</li>
        <li><strong>Accountability & Community Control:</strong> Create a District Jobs & Growth Council of local workers, business owners, educators, and union leaders to guide policy, review results, and recommend improvements. Require all new business incentives to include local hiring guarantees and wage standards—with clawbacks for companies that don't deliver.</li>
      </ul>
    HTML
    summary: "Union Jobs: Fast-track grants & apprenticeships\nSkills Training: Tuition-free trades & IT programs\nSmall Business: Start-Here Fund & Buy Local First\nRural Growth: Job hubs & universal broadband\nGreen Jobs: Clean energy, infrastructure, and conservation\nVeterans/2nd Chance: Skills bridge and re-entry hiring incentives\nFamily Support: Affordable care, transit, flexible work\nAccountability: Local jobs council and performance standards"
  },
  {
    title: "Healthcare",
    icon: "heart",
    position: 3,
    featured: true,
    tagline: "Our families deserve more than corporate healthcare and broken promises. We'll cut costs, protect workers, and put people first—not profits.",
    description: <<~HTML,
      <p>In South Carolina's 5th District, families are tired of broken promises on healthcare. We're building something new — something that puts people over profit, and results over rhetoric.</p>
      <h2>✅ Health & Wellness Hubs in Every County</h2>
      <p>Local, nonprofit "Health & Wellness Hubs" will provide primary care, dental, mental health services, and telemedicine access. Operated by local boards — not insurance companies — these hubs are designed to serve the people, not pad profits.</p>
      <h2>✅ UnionCare: Portable Benefits for Workers</h2>
      <p>A regional benefits pool for all workers — especially small business employees, contractors, and union families — allowing them to keep affordable care even between jobs.</p>
      <h2>✅ State-Backed Generic Drug Production</h2>
      <p>We'll partner with universities and manufacturers to produce low-cost generics like insulin and EpiPens right here in South Carolina — cutting costs and creating jobs.</p>
      <h2>✅ First Responder Mental Health Bill of Rights</h2>
      <p>Emergency workers deserve confidential, accessible, stigma-free mental healthcare — and we'll make it law.</p>
      <h2>✅ Transparent, Patient-Friendly Pricing</h2>
      <p>Every hub will publish public dashboards showing wait times, service availability, and pricing. It's your care — you deserve to understand it.</p>
    HTML
    summary: "Health Hubs: County-based nonprofit care centers\nUnionCare: Portable benefits for all workers\nDrug Costs: State-backed generic production\nFirst Responders: Mental Health Bill of Rights\nTransparency: Public dashboards for pricing and wait times"
  },
  {
    title: "Public Education",
    icon: "grad-cap",
    position: 4,
    featured: true,
    tagline: "Every child in South Carolina deserves a quality education—no matter their ZIP code, income level, or background.",
    description: <<~HTML,
      <p>Every child in South Carolina deserves a quality education—no matter their ZIP code, income level, or background. As your representative, I will fight to ensure every student has the tools, support, and opportunity to succeed.</p>
      <h2>✏️ Invest in Public Schools and Teachers</h2>
      <p>Our teachers are heroes, yet too many are overworked and underpaid. We must raise teacher salaries to attract and retain top talent, reduce class sizes, and invest in classroom resources. Education funding should go directly to public schools—not siphoned off by corporate voucher schemes.</p>
      <h2>🛠️ Expand Vocational, Technical & STEM Training</h2>
      <p>College isn't the only path to success. We need more high school programs that prepare students for skilled trades, advanced manufacturing, computer science, healthcare, and green energy jobs. I support expanding dual-enrollment, apprenticeships, and job certification pipelines.</p>
      <h2>🚌 Support Rural and Underserved Communities</h2>
      <p>In rural districts and low-income neighborhoods, students too often face outdated buildings, bus shortages, and a lack of broadband access. I will fight for fair funding formulas and federal investments to close the gap for these communities—ensuring no student is left behind.</p>
      <h2>📚 Protect Education from Political Interference</h2>
      <p>Politicians shouldn't be rewriting history books or banning honest discussions in classrooms. I will defend educators' rights to teach the truth, foster critical thinking, and build inclusive schools where every student feels safe and respected.</p>
    HTML
    summary: "Teacher Pay: Raise salaries, reduce class sizes\nSTEM & Trades: Expand vocational and technical programs\nRural Schools: Fair funding and broadband access\nAcademic Freedom: Protect teachers from political interference"
  },
  {
    title: "Immigration",
    icon: "flag",
    position: 5,
    featured: true,
    tagline: "This is not just policy to me. It's personal. My family has lived this broken system—and I'll fight like hell to fix it.",
    description: <<~HTML,
      <h2>Restoring Dignity, Securing Borders, and Reuniting Families</h2>
      <p>As someone who knows the immigration system firsthand, Andrew Clough believes in a common-sense approach that reflects the values of South Carolina's 5th District: faith, family, hard work, and justice.</p>
      <h3>1. Earned Pathway to Residency</h3>
      <p>For undocumented immigrants living in the U.S. over 10 years with no criminal record. Includes background checks, tax payment, and English/civics requirements with a 10-year roadmap to permanent status.</p>
      <h3>2. Family First Act</h3>
      <p>Eliminates harsh bars that separate families and expedites visa processing for spouses and children of U.S. citizens. Reduces backlogs with tech and caseworkers.</p>
      <h3>3. Fair Work, Fair Future</h3>
      <p>Modernizes visa systems to help SC-5 industries hire legally and ethically. Creates a "Blue Card" for essential workers with a path to citizenship and worker protections.</p>
      <h3>4. Smart Border, Not a Big Wall</h3>
      <p>Secures the border with drones, sensors, and increased immigration court staffing. Focuses on technology and diplomacy—not walls and fear.</p>
      <h3>5. American Dream Fund</h3>
      <p>Protects DREAMers and TPS holders with permanent status, educational grants, and small business access. Codifies DACA into federal law.</p>
      <h3>Local Action for SC-5</h3>
      <ul>
        <li>Support an Immigrant Resource Office in York or Lancaster County</li>
        <li>Expand access to municipal IDs for undocumented residents</li>
        <li>Host legal aid and naturalization workshops with local partners</li>
      </ul>
    HTML
    summary: "Earned Pathway: 10-year roadmap for long-term residents\nFamily First: End family separation, speed visa processing\nFair Work: Blue Card for essential workers\nSmart Border: Technology, not walls\nDreamers: Codify DACA, protect TPS holders"
  },
  {
    title: "Democracy & Representation",
    icon: "check-circle",
    position: 6,
    featured: true,
    tagline: "Our democracy only works when every voice is heard and every vote counts. I'm running for Congress to restore faith in our democratic process—and put the power back where it belongs: in the hands of the people.",
    description: <<~HTML,
      <p>Our democracy only works when every voice is heard and every vote counts. But right now, dark money, partisan gerrymandering, and voter suppression are threatening the foundation of our republic.</p>
      <h2>🗳️ Protect Voting Rights</h2>
      <p>I support restoring and expanding the Voting Rights Act. Every eligible citizen should have equal and easy access to the ballot box—regardless of their zip code, race, age, or background. That means early voting, vote-by-mail options, and automatic voter registration.</p>
      <h2>🧾 End Gerrymandering</h2>
      <p>Politicians shouldn't pick their voters—voters should pick their politicians. I support independent redistricting commissions to draw fair, nonpartisan maps that truly reflect our communities and restore competitive elections.</p>
      <h2>💸 Get Big Money Out of Politics</h2>
      <p>I support full transparency in campaign finance and a constitutional amendment to overturn <em>Citizens United</em>. We need to limit the influence of corporate PACs and dark money groups—and lift up grassroots voices instead.</p>
      <h2>🔁 Enact Term Limits for Congress</h2>
      <p>Career politicians lose touch with the people they serve. I support term limits for members of Congress to make room for fresh ideas, prevent entrenched power, and keep our government accountable to the people.</p>
    HTML
    summary: "Voting Rights: Restore the Voting Rights Act\nEnd Gerrymandering: Independent redistricting commissions\nCampaign Finance: Overturn Citizens United\nTerm Limits: Fresh leadership, accountability"
  },
  {
    title: "Infrastructure & Community Investment",
    icon: "building",
    position: 7,
    featured: false,
    tagline: "Building a stronger, more connected South Carolina's 5th District.",
    description: <<~HTML,
      <p>Building a stronger, more connected South Carolina's 5th District.</p>
      <h2>Our Priorities</h2>
      <ul>
        <li><strong>Repair and Modernize Roads & Bridges:</strong> Address the backlog of crumbling rural and urban roads, prioritize safety, and create local construction jobs.</li>
        <li><strong>Expand High-Speed Broadband:</strong> Close the digital divide and bring affordable internet access to every community, supporting education and small businesses.</li>
        <li><strong>Reduce Traffic Congestion:</strong> Invest in smart transit solutions and practical improvements to keep people and commerce moving efficiently.</li>
        <li><strong>Public Transit for All:</strong> Develop reliable, accessible transit options for underserved areas, connecting residents to jobs, healthcare, and opportunity.</li>
        <li><strong>Strengthen Public Schools:</strong> Upgrade school facilities and invest in technology so every student has the tools to succeed.</li>
      </ul>
    HTML
    summary: "Roads & Bridges: Repair crumbling infrastructure\nBroadband: Close the digital divide\nTransit: Smart solutions for all communities\nSchools: Upgrade facilities and technology"
  },
  {
    title: "Term Limits",
    icon: "clock",
    position: 8,
    featured: false,
    tagline: "Career politicians have turned Washington into a place where power protects itself. It's time for real change.",
    description: <<~HTML,
      <p>Career politicians have turned Washington into a place where power protects itself. Too many lawmakers spend decades in office, growing further out of touch with the people they're supposed to represent. That's not how democracy is supposed to work — and it's time for real change.</p>
      <h2>🔁 Fresh Leadership, New Ideas</h2>
      <p>Term limits will bring fresh perspectives to Congress and ensure that public service doesn't become a lifelong career. When new leaders step up, our government becomes more innovative, more reflective of the people, and more responsive to the challenges of today — not yesterday.</p>
      <h2>🧭 Accountability to the People</h2>
      <p>I believe members of Congress should be focused on serving their constituents — not protecting their own power. Term limits help prevent the entrenchment of special interests and make room for public servants who lead with purpose, not politics.</p>
      <h2>🛠️ My Commitment</h2>
      <p>If elected, I will fight to pass term limits for both the House and Senate. I also pledge to lead by example — and will not make Congress my career. Public office should be a season of service, not a lifetime entitlement.</p>
    HTML
    summary: "Fresh Leadership: Bring new perspectives to Congress\nAccountability: Prevent entrenchment of special interests\nMy Pledge: Lead by example, serve, don't career"
  }
]

# Update or create issues
issues_data.each do |data|
  issue = Issue.find_by(title: data[:title])
  
  if issue
    puts "Updating existing issue: #{data[:title]}"
    issue.update!(
      description: data[:description],
      tagline: data[:tagline],
      summary: data[:summary],
      icon: data[:icon],
      position: data[:position],
      featured: data[:featured],
      status: :active
    )
  else
    puts "Creating new issue: #{data[:title]}"
    Issue.create!(
      title: data[:title],
      description: data[:description],
      tagline: data[:tagline],
      summary: data[:summary],
      icon: data[:icon],
      position: data[:position],
      featured: data[:featured],
      status: :active
    )
  end
end

puts "\nDone! Total active issues: #{Issue.active.count}"

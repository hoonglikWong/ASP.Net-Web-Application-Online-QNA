//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MasterpageTest.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class MCQAssessmentList
    {
        public string Email { get; set; }
        public int MCQAssessmentID { get; set; }
        public string Completion { get; set; }
        public string Assignment { get; set; }
    
        public virtual MCQAssessment MCQAssessment { get; set; }
        public virtual Person Person { get; set; }
    }
}

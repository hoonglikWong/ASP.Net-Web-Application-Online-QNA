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
    
    public partial class WrittenAssessment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public WrittenAssessment()
        {
            this.WrittenAssessmentLists = new HashSet<WrittenAssessmentList>();
            this.WrittenQuestions = new HashSet<WrittenQuestion>();
            this.WrittenResults = new HashSet<WrittenResult>();
        }
    
        public int WrittenID { get; set; }
        public string WrittenTitle { get; set; }
        public string WrittenLectureEmail { get; set; }
        public string WrittenAssessmentType { get; set; }
    
        public virtual Person Person { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WrittenAssessmentList> WrittenAssessmentLists { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WrittenQuestion> WrittenQuestions { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WrittenResult> WrittenResults { get; set; }
    }
}